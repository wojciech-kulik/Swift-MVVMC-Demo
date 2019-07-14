import Foundation
import RxSwift

class DashboardCoordinator: BaseCoordinator<Void> {
    
    var mainViewController: MainViewController!
    var dashboardViewController: BaseNavigationController!
    
    private let dashboardViewModel: DashboardViewModel
    private let dataManager: DataManager
    
    init(dashboardViewModel: DashboardViewModel, dataManager: DataManager) {
        self.dashboardViewModel = dashboardViewModel
        self.dataManager = dataManager
    }
    
    override func start() -> Maybe<Void> {
        let viewController = DashboardViewController.instantiate()
        viewController.viewModel = self.dashboardViewModel
        
        self.dashboardViewController = BaseNavigationController(rootViewController: viewController)
        self.mainViewController.display(viewController: self.dashboardViewController)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.showOnBoardingIfNeeded()
        }
        
        return Maybe.never()
    }
    
    func showOnBoardingIfNeeded() {
        guard self.dataManager.get(key: SettingKey.onBoardingData, type: OnBoardingData.self) == nil else { return }
        
        let coordinator = AppDelegate.container.resolve(OnBoardingCoordinator.self)!
        coordinator.navigationController = self.dashboardViewController
        
        self.coordinate(to: coordinator)
            .subscribe(onSuccess: { [weak self] _ in
                self?.dashboardViewController.dismiss(animated: true, completion: nil)
            })
            .disposed(by: self.disposeBag)
    }
}
