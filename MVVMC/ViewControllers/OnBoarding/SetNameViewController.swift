import Foundation
import UIKit
import RxSwift

class SetNameViewController: UIViewController, Storyboarded {
    
    static var storyboard = AppStoryboard.onBoarding
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var firstNameTextField: LocalizedTextField!
    @IBOutlet weak var lastNameTextField: LocalizedTextField!
    @IBOutlet weak var nextButton: LocalizedButton!
    
    var viewModel: SetNameViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureDismissKeyboard()
        self.setUpBindings()
    }
    
    func setUpBindings() {
        guard let viewModel = self.viewModel else { return }
        
        Observable.of(self.firstNameTextField, self.lastNameTextField)
            .flatMap { $0.rx.controlEvent(.editingDidEndOnExit) }
            .withLatestFrom(viewModel.isNextActive)
            .filter { $0 }
            .map { _ in Void() }
            .bind(to: viewModel.didTapNext)
            .disposed(by: self.disposeBag)
        
        self.firstNameTextField.rx.text.orEmpty
            .bind(to: viewModel.firstName)
            .disposed(by: self.disposeBag)
        
        self.lastNameTextField.rx.text.orEmpty
            .bind(to: viewModel.lastName)
            .disposed(by: self.disposeBag)
        
        self.nextButton.rx.tap
            .bind(to: viewModel.didTapNext)
            .disposed(by: self.disposeBag)
        
        viewModel.isNextActive
            .bind(to: self.nextButton.rx.isEnabled)
            .disposed(by: self.disposeBag)
    }
}
