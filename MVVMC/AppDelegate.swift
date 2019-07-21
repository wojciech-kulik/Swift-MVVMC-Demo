import UIKit
import Swinject
import SideMenu
import RxSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private let disposeBag = DisposeBag()
    private var appCoordinator: AppCoordinator!
    
    static let container = Container()
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        Container.loggingFunction = nil
        AppDelegate.container.registerDependencies()
        
        self.setUpSideMenu()
        
        self.appCoordinator = AppDelegate.container.resolve(AppCoordinator.self)!
        self.appCoordinator.start()
            .subscribe()
            .disposed(by: self.disposeBag)

        return true
    }
    
    private func setUpSideMenu() {
        let sideMenuController = UISideMenuNavigationController(rootViewController: DrawerMenuViewController.instantiate())
        sideMenuController.navigationBar.isHidden = true
        
        SideMenuManager.default.menuLeftNavigationController = sideMenuController
        SideMenuManager.default.menuFadeStatusBar = false
        SideMenuManager.default.menuPresentMode = .menuSlideIn
        SideMenuManager.default.menuWidth = max(round(min((UIScreen.main.bounds.width), (UIScreen.main.bounds.height)) * 0.75), 240)
        SideMenuManager.defaultManager.menuAnimationFadeStrength = 0.32
    }
}
