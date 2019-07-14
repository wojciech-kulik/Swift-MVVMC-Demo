import Foundation
import UIKit
import RxSwift
import RxCocoa

class SignInCoordinator: BaseCoordinator<Void> {
    
    private let viewModel: SignInViewModel
    
    init(viewModel: SignInViewModel) {
        self.viewModel = viewModel
    }
    
    override func start() -> Maybe<Void> {
        let viewController = SignInViewController.instantiate()
        viewController.viewModel = viewModel
        
        ViewControllerUtils.setRootViewController(
            window: UIApplication.shared.windows.first,
            viewController: viewController,
            withAnimation: true)
        
        return Maybe.never()
    }
}
