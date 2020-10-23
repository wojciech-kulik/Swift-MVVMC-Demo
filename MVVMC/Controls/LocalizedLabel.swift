import Foundation
import UIKit

class LocalizedLabel: UILabel {
    @IBInspectable var localizationKey: String?
    @IBInspectable var upperText: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if localizationKey == nil {
            assertionFailure("Translation key not set for \(text ?? "")")
        }
        text = upperText ? localizationKey?.localizedUpper : localizationKey?.localized
    }
}
