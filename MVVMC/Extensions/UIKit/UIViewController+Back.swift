import Foundation
import UIKit

extension UIViewController {
    
    func setBackButton(title: String) {
        let backButton = UIBarButtonItem(title: title.localized, style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backButton
    }
    
    func setDefaultBackButton() {
        let backButton = UIBarButtonItem(title: "Back".localized, style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backButton
    }
}
