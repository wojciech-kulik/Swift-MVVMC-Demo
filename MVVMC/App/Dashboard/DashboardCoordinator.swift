import Foundation
import UIKit

class DashboardCoordinator: BaseCoordinator {
    
    private let dashboardViewModel: DashboardViewModel
    private let dataManager: DataManager
    
    init(dashboardViewModel: DashboardViewModel, dataManager: DataManager) {
        self.dashboardViewModel = dashboardViewModel
        self.dataManager = dataManager
    }
    
    override func start() {
        let viewController = DashboardViewController.instantiate()
        viewController.viewModel = self.dashboardViewModel
        
        self.navigationController.viewControllers = [viewController]
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.showOnBoardingIfNeeded()
        }
    }
    
    func showOnBoardingIfNeeded() {
        guard self.dataManager.get(key: SettingKey.onBoardingData, type: OnBoardingData.self) == nil else { return }
        
        let coordinator = AppDelegate.container.resolve(OnBoardingCoordinator.self)!
        coordinator.navigationController = self.navigationController
        
        self.start(coordinator: coordinator)
    }
}
