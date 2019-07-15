import Foundation
import RxSwift
import UIKit

class DashboardCoordinator: BaseCoordinator<Void> {
    
    private let dashboardViewModel: DashboardViewModel
    private let dataManager: DataManager
    
    var navigationController = UINavigationController()
    
    init(dashboardViewModel: DashboardViewModel, dataManager: DataManager) {
        self.dashboardViewModel = dashboardViewModel
        self.dataManager = dataManager
    }
    
    override func start() -> Maybe<Void> {
        let viewController = DashboardViewController.instantiate()
        viewController.viewModel = self.dashboardViewModel
        
        self.navigationController.viewControllers = [viewController]
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.showOnBoardingIfNeeded()
        }
        
        return Maybe.never()
    }
    
    func showOnBoardingIfNeeded() {
        guard self.dataManager.get(key: SettingKey.onBoardingData, type: OnBoardingData.self) == nil else { return }
        
        let coordinator = AppDelegate.container.resolve(OnBoardingCoordinator.self)!
        coordinator.navigationController = self.navigationController
        
        self.coordinate(to: coordinator)
            .subscribe()
            .disposed(by: self.disposeBag)
    }
}
