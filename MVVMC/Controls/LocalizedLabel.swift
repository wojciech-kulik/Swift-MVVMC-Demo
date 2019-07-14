import Foundation
import UIKit

class LocalizedLabel: UILabel {
    @IBInspectable var localizationKey: String?
    @IBInspectable var upperText: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if self.localizationKey == nil {
            assertionFailure("Translation key not set for \(self.text ?? "")")
        }
        self.text = self.upperText ? self.localizationKey?.localizedUpper : self.localizationKey?.localized
    }
}
