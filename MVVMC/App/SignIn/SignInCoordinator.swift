import Foundation
import UIKit

class SignInCoordinator: BaseCoordinator {
    
    private let viewModel: SignInViewModel
    
    init(viewModel: SignInViewModel) {
        self.viewModel = viewModel
    }
    
    override func start() {
        let viewController = SignInViewController.instantiate()
        viewController.viewModel = viewModel
        
        self.navigationController.isNavigationBarHidden = true
        self.navigationController.viewControllers = [viewController]
    }
}
