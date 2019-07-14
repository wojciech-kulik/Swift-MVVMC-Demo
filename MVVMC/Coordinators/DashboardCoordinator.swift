import Foundation
import RxSwift

class DashboardCoordinator: BaseCoordinator<Void> {
    
    var rootViewController: MainViewController!
    var navigationController: BaseNavigationController!
    
    private let dashboardViewModel: DashboardViewModel
    private let dataManager: DataManager
    
    init(dashboardViewModel: DashboardViewModel, dataManager: DataManager) {
        self.dashboardViewModel = dashboardViewModel
        self.dataManager = dataManager
    }
    
    override func start() -> Maybe<Void> {
        let viewController = DashboardViewController.instantiate()
        viewController.viewModel = self.dashboardViewModel
        
        self.navigationController = BaseNavigationController(rootViewController: viewController)
        rootViewController.display(viewController: self.navigationController)
        
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
            .subscribe(onSuccess: { [weak self] _ in
                self?.navigationController.dismiss(animated: true, completion: nil)
            })
            .disposed(by: self.disposeBag)
    }
}
