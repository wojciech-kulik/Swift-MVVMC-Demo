import Foundation
import RxSwift

class SetNameViewModel {
    private let disposeBag = DisposeBag()
    
    let firstName = BehaviorSubject(value: "")
    let lastName = BehaviorSubject(value: "")
    let didTapNext = PublishSubject<Void>()
    let isNextActive = BehaviorSubject<Bool>(value: false)
    
    init() {
        setUpBindings()
    }
    
    private func setUpBindings() {
        Observable
            .combineLatest(firstName, lastName)
            .map { $0.hasNonEmptyValue() && $1.hasNonEmptyValue() }
            .bind(to: isNextActive)
            .disposed(by: disposeBag)
    }
}
