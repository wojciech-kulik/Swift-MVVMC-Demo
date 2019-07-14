import Foundation
import UIKit

class ErrorHandler {
    
    private var lastError: ErrorMessage?
    
    func handle(error: ErrorMessage) {
        guard self.lastError != error else { return }
        self.lastError = error
        
        var topViewController = UIApplication.shared.keyWindow?.rootViewController
        while topViewController?.presentedViewController != nil {
            topViewController = topViewController?.presentedViewController
        }
        
        if let viewController = topViewController {
            viewController.displayError(error: error) {
                self.lastError = nil
            }
        }
    }
}
