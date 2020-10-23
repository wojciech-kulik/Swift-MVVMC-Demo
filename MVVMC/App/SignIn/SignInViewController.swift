import UIKit
import RxSwift
import RxCocoa

class SignInViewController: UIViewController, Storyboarded {
    static var storyboard = AppStoryboard.signIn

    @IBOutlet weak var usernameTextField: LocalizedTextField!
    @IBOutlet weak var passwordTextField: LocalizedTextField!
    @IBOutlet weak var signInButton: ButtonWithProgress!

    private let disposeBag = DisposeBag()
    var viewModel: SignInViewModel?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDismissKeyboard()
        setUpBindings()
    }
    
    private func setUpBindings() {
        guard let viewModel = viewModel else { return }
        
        Observable.of(usernameTextField, passwordTextField)
            .flatMap { $0.rx.controlEvent(.editingDidEndOnExit) }
            .withLatestFrom(viewModel.isSignInActive)
            .filter { $0 }
            .bind { [weak self] _ in self?.viewModel?.signIn() }
            .disposed(by: disposeBag)
        
        usernameTextField.rx.text.orEmpty
            .bind(to: viewModel.email)
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text.orEmpty
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)
        
        signInButton.rx.tap
            .bind { [weak self] in self?.viewModel?.signIn() }
            .disposed(by: disposeBag)
        
        viewModel.isSignInActive
            .bind(to: signInButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        viewModel.isLoading
            .bind { [weak self] in
                guard let self = self else { return }
                self.usernameTextField.isEnabled = !$0
                self.passwordTextField.isEnabled = !$0
                self.signInButton.isInProgress = $0
            }
            .disposed(by: disposeBag)
    }
}
