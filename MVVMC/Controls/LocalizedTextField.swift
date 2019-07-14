import Foundation
import UIKit

class LocalizedTextField: UITextField {
    @IBInspectable var placeholderLocalizationKey: String?
    @IBInspectable var upperText: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if (self.placeholder?.hasNonEmptyValue() ?? false) && self.placeholderLocalizationKey == nil {
            assertionFailure("Translation key not set for \(self.text ?? "")")
        }
        self.placeholder = self.upperText
            ? self.placeholderLocalizationKey?.localizedUpper ?? self.placeholder
            : self.placeholderLocalizationKey?.localized ?? self.placeholder
    }
}
