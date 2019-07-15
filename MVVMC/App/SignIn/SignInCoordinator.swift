import Foundation
import UIKit
import RxSwift
import RxCocoa

class SignInCoordinator: BaseCoordinator<Void> {
    
    private let viewModel: SignInViewModel
    var navigationController: UINavigationController = {
        let controller = UINavigationController()
        controller.navigationBar.isHidden = true
        return controller
    }()
    
    init(viewModel: SignInViewModel) {
        self.viewModel = viewModel
    }
    
    override func start() -> Maybe<Void> {
        let viewController = SignInViewController.instantiate()
        viewController.viewModel = viewModel
        
        self.navigationController.viewControllers = [viewController]

        return Maybe.never()
    }
}
