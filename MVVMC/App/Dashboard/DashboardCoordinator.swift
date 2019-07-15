import Foundation
import RxSwift
import UIKit

class DashboardCoordinator: BaseCoordinator<Void> {
    
    private let dashboardViewModel: DashboardViewModel
    private let dataManager: DataManager
    
    init(dashboardViewModel: DashboardViewModel, dataManager: DataManager) {
        self.dashboardViewModel = dashboardViewModel
        self.dataManager = dataManager
    }
    
    override func start() -> Maybe<Void> {
        let viewController = DashboardViewController.instantiate()
        viewController.viewModel = self.dashboardViewModel
        let dashboardViewController = BaseNavigationController(rootViewController: viewController)
        
        ViewControllerUtils.setRootViewController(viewController: dashboardViewController,
                                                  withAnimation: false)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.showOnBoardingIfNeeded(navigationController: dashboardViewController)
        }
        
        return Maybe.never()
    }
    
    func showOnBoardingIfNeeded(navigationController: UINavigationController) {
        guard self.dataManager.get(key: SettingKey.onBoardingData, type: OnBoardingData.self) == nil else { return }
        
        let coordinator = AppDelegate.container.resolve(OnBoardingCoordinator.self)!
        coordinator.navigationController = navigationController
        
        self.coordinate(to: coordinator)
            .subscribe()
            .disposed(by: self.disposeBag)
    }
}
