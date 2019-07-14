import Foundation
import UIKit

extension UIButton {
    func setTitle(_ title: String?) {
        UIView.performWithoutAnimation {
            self.setTitle(title, for: .normal)
            self.layoutIfNeeded()
        }
    }
}
