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
        self.configureDismissKeyboard()
        self.setUpBindings()
    }
    
    private func setUpBindings() {
        guard let viewModel = self.viewModel else { return }
        
        Observable.of(self.usernameTextField, self.passwordTextField)
            .flatMap { $0.rx.controlEvent(.editingDidEndOnExit) }
            .withLatestFrom(viewModel.isSignInActive)
            .filter { $0 }
            .bind { [weak self] _ in self?.viewModel?.signIn() }
            .disposed(by: self.disposeBag)
        
        self.usernameTextField.rx.text.orEmpty
            .bind(to: viewModel.email)
            .disposed(by: self.disposeBag)
        
        self.passwordTextField.rx.text.orEmpty
            .bind(to: viewModel.password)
            .disposed(by: self.disposeBag)
        
        self.signInButton.rx.tap
            .bind { [weak self] in self?.viewModel?.signIn() }
            .disposed(by: self.disposeBag)
        
        viewModel.isSignInActive
            .bind(to: self.signInButton.rx.isEnabled)
            .disposed(by: self.disposeBag)
        
        viewModel.isLoading
            .bind { [weak self] in
                guard let `self` = self else { return }
                self.usernameTextField.isEnabled = !$0
                self.passwordTextField.isEnabled = !$0
                self.signInButton.isInProgress = $0
            }
            .disposed(by: self.disposeBag)
    }
}
