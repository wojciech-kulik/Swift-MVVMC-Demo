import Foundation
import RxSwift
import UIKit

class SettingsCoordinator: BaseCoordinator<Void> {
    
    private let settingsViewModel: SettingsViewModel
    
    init(settingsViewModel: SettingsViewModel) {
        self.settingsViewModel = settingsViewModel
    }
    
    override func start() -> Maybe<Void> {
        let viewController = SettingsViewController.instantiate()
        viewController.viewModel = self.settingsViewModel
        
        self.navigationController.viewControllers = [viewController]
        
        return Maybe.never()
    }
}
