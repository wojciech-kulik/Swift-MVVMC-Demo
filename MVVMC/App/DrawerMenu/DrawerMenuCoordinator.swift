import Foundation
import RxSwift
import RxCocoa
import SideMenu

class DrawerMenuCoordinator: BaseCoordinator<Void> {
    
    private weak var mainViewController: MainViewController?
    private let sessionService: SessionService
    private let drawerMenuViewModel: DrawerMenuViewModel
    
    init(sessionService: SessionService, drawerMenuViewModel: DrawerMenuViewModel) {
        self.drawerMenuViewModel = drawerMenuViewModel
        self.sessionService = sessionService
    }
    
    override func start() -> Maybe<Void> {
        self.mainViewController = MainViewController.instantiate()
        
        drawerMenuViewModel.didSelectScreen
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] screen in
                self?.selectScreen(screen)
            })
            .disposed(by: self.disposeBag)
        
        let menuViewController = SideMenuManager.default.menuLeftNavigationController?.topViewController as? DrawerMenuViewController
        menuViewController?.viewModel = drawerMenuViewModel
        
        ViewControllerUtils.setRootViewController(
            window: UIApplication.shared.windows.first,
            viewController: self.mainViewController!,
            withAnimation: true)
        
        return Maybe.never()
    }
    
    func selectScreen(_ screen: SelectedScreen) {
        Logger.info("Selected screen: \(screen)")
        
        switch screen {
        case .dashboard:
            self.removeChildCoordinators()
            let coordinator = AppDelegate.container.resolve(DashboardCoordinator.self)!
            coordinator.mainViewController = self.mainViewController
            self.coordinate(to: coordinator)
                .subscribe()
                .disposed(by: self.disposeBag)
            
        case .settings:
            self.removeChildCoordinators()
            let coordinator = AppDelegate.container.resolve(SettingsCoordinator.self)!
            coordinator.mainViewController = self.mainViewController
            self.coordinate(to: coordinator)
                .subscribe()
                .disposed(by: self.disposeBag)
            
        case .signOut:
            self.sessionService.signOut()
                .subscribe()
                .disposed(by: self.disposeBag)
            
        default:
            break
        }
    }
}
