import Foundation
import UIKit

extension UIViewController {
    
    func displayError(error: ErrorMessage, completion: @escaping () -> Void = { }) {
        let alert = UIAlertController(title: error.title.localized, message: error.message.localized, preferredStyle: .alert)
        
        for button in error.buttons {
            let alertAction = UIAlertAction(title: button.localized, style: .default) { _ in
                error.actions[button]?()
                completion()
            }
            
            alert.addAction(alertAction)
        }
        self.present(alert, animated: true)
    }
    
    func displayError(error: ErrorMessage, completion: @escaping  (String) -> Void) {
        let alert = UIAlertController(title: error.title.localized, message: error.message.localized, preferredStyle: .alert)
        
        for button in error.buttons {
            let alertAction = UIAlertAction(title: button.localized, style: .default) { _ in
                completion(button)
            }
            
            alert.addAction(alertAction)
        }
        self.present(alert, animated: true)
    }
}
