import Foundation
import UIKit

class LocalizedTextField: UITextField {
    @IBInspectable var placeholderLocalizationKey: String?
    @IBInspectable var upperText: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if (placeholder?.hasNonEmptyValue() ?? false) && placeholderLocalizationKey == nil {
            assertionFailure("Translation key not set for \(text ?? "")")
        }
        placeholder = upperText
            ? placeholderLocalizationKey?.localizedUpper ?? placeholder
            : placeholderLocalizationKey?.localized ?? placeholder
    }
}
