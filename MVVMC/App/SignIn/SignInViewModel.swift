import RxSwift

class SignInViewModel {
	private let sessionService: SessionService
    private let disposeBag = DisposeBag()
    
    let email = BehaviorSubject<String>(value: "")
    let password = BehaviorSubject<String>(value: "")
    let isSignInActive = BehaviorSubject<Bool>(value: false)
    let isLoading = BehaviorSubject<Bool>(value: false)
    
    init(sessionService: SessionService) {
        self.sessionService = sessionService
        setUpBindings()
    }
    
    func signIn() {
        isLoading.onNext(true)
        
        Observable
            .combineLatest(email, password, isSignInActive)
            .take(1)
            .filter { _, _, active in active }
            .map { username, password, _ in Credentials(username: username, password: password) }
            .flatMapLatest { [weak self] in self?.sessionService.signIn(credentials: $0) ?? Completable.empty() }
            .subscribe { [weak self] _ in self?.isLoading.onNext(false) }
            .disposed(by: disposeBag)
    }
    
    private func setUpBindings() {
        Observable
            .combineLatest(email, password)
            .map { $0.hasNonEmptyValue() && $1.hasNonEmptyValue() }
            .bind(to: isSignInActive)
            .disposed(by: disposeBag)
    }
}
