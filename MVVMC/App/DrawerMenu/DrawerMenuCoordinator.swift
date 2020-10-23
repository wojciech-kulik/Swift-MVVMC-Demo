import Foundation
import RxSwift
import RxCocoa
import SideMenu

class DrawerMenuCoordinator: BaseCoordinator {
    private let disposeBag = DisposeBag()
    private let sessionService: SessionService
    private let drawerMenuViewModel: DrawerMenuViewModel

    init(sessionService: SessionService, drawerMenuViewModel: DrawerMenuViewModel) {
        self.drawerMenuViewModel = drawerMenuViewModel
        self.sessionService = sessionService
    }
    
    override func start() {
        drawerMenuViewModel.didSelectScreen
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] screen in self?.selectScreen(screen) })
            .disposed(by: disposeBag)
        
        let drawerMenu = SideMenuManager.default.leftMenuNavigationController
        let menuViewController = drawerMenu?.topViewController as? DrawerMenuViewController
        menuViewController?.viewModel = drawerMenuViewModel
    }
    
    func selectScreen(_ screen: DrawerMenuScreen) {
        Logger.info("Selected screen: \(screen)")
        
        switch screen {
        case .dashboard:
            removeChildCoordinators()
            let coordinator = AppDelegate.container.resolve(DashboardCoordinator.self)!
            coordinator.navigationController = navigationController
            start(coordinator: coordinator)
            
        case .settings:
            removeChildCoordinators()
            let coordinator = AppDelegate.container.resolve(SettingsCoordinator.self)!
            coordinator.navigationController = navigationController
            start(coordinator: coordinator)
            
        case .signOut:
            sessionService.signOut()
                .subscribe()
                .disposed(by: disposeBag)
        }
    }
}
