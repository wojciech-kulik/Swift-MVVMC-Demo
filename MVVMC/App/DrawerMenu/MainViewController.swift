import Foundation
import UIKit

class MainViewController: UIViewController, Storyboarded {
    
    static var storyboard = AppStoryboard.drawer
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
