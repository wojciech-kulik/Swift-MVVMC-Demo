import Foundation
import UIKit

extension UIViewController {
   func display(viewController: UIViewController) {
        for child in self.children {
            self.remove(viewController: child)
        }
        self.add(viewController: viewController)
    }
    
    func add(viewController: UIViewController) {
        self.addChild(viewController)
        self.view.addSubview(viewController.view)
        viewController.didMove(toParent: self)
    }
    
    func remove(viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
}
