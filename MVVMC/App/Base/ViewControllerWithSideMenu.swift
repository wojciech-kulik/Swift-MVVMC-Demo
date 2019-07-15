import Foundation
import UIKit
import SideMenu

class ViewControllerWithSideMenu: UIViewController {
    
    var panGesture = UIPanGestureRecognizer()
    var edgeGesture = [UIScreenEdgePanGestureRecognizer]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.panGesture = SideMenuManager.default.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        self.edgeGesture = SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view, forMenu: .left)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: .plain, target: self, action: #selector(self.hamburgerMenuClicked))
        self.navigationItem.leftBarButtonItem?.accessibilityIdentifier = "menuButton"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.enableSideMenu()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.disableSideMenu()
    }
    
    func disableSideMenu() {
        self.panGesture.isEnabled = false
        self.edgeGesture.forEach { $0.isEnabled = false }
    }
    
    func enableSideMenu() {
        self.panGesture.isEnabled = true
        self.edgeGesture.forEach { $0.isEnabled = true }
    }
    
    func showSideMenu() {
        self.present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
    }
    
    @objc func hamburgerMenuClicked() {
        self.showSideMenu()
    }
}
