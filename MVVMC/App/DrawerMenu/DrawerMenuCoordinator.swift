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
        self.drawerMenuViewModel.didSelectScreen
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] screen in self?.selectScreen(screen) })
            .disposed(by: self.disposeBag)
        
        let drawerMenu = SideMenuManager.default.menuLeftNavigationController
        let menuViewController = drawerMenu?.topViewController as? DrawerMenuViewController
        menuViewController?.viewModel = self.drawerMenuViewModel
    }
    
    func selectScreen(_ screen: DrawerMenuScreen) {
        Logger.info("Selected screen: \(screen)")
        
        switch screen {
        case .dashboard:
            self.removeChildCoordinators()
            let coordinator = AppDelegate.container.resolve(DashboardCoordinator.self)!
            coordinator.navigationController = self.navigationController
            self.start(coordinator: coordinator)
            
        case .settings:
            self.removeChildCoordinators()
            let coordinator = AppDelegate.container.resolve(SettingsCoordinator.self)!
            coordinator.navigationController = self.navigationController
            self.start(coordinator: coordinator)
            
        case .signOut:
            self.sessionService.signOut()
                .subscribe()
                .disposed(by: self.disposeBag)
        }
    }
}
