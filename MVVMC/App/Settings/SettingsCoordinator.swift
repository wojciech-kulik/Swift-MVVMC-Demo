import Foundation
import RxSwift

class SettingsCoordinator: BaseCoordinator<Void> {
    
    var mainViewController: MainViewController!
    private let settingsViewModel: SettingsViewModel
    
    init(settingsViewModel: SettingsViewModel) {
        self.settingsViewModel = settingsViewModel
    }
    
    override func start() -> Maybe<Void> {
        let viewController = SettingsViewController.instantiate()
        viewController.viewModel = self.settingsViewModel
        
        self.mainViewController.display(viewController: BaseNavigationController(rootViewController: viewController))
        
        return Maybe.never()
    }
}
