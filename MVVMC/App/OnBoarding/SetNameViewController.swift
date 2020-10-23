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
        configureDismissKeyboard()
        setUpBindings()
    }
    
    func setUpBindings() {
        guard let viewModel = viewModel else { return }
        
        Observable.of(firstNameTextField, lastNameTextField)
            .flatMap { $0.rx.controlEvent(.editingDidEndOnExit) }
            .withLatestFrom(viewModel.isNextActive)
            .filter { $0 }
            .map { _ in Void() }
            .bind(to: viewModel.didTapNext)
            .disposed(by: disposeBag)
        
        firstNameTextField.rx.text.orEmpty
            .bind(to: viewModel.firstName)
            .disposed(by: disposeBag)
        
        lastNameTextField.rx.text.orEmpty
            .bind(to: viewModel.lastName)
            .disposed(by: disposeBag)
        
        nextButton.rx.tap
            .bind(to: viewModel.didTapNext)
            .disposed(by: disposeBag)
        
        viewModel.isNextActive
            .bind(to: nextButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
}
