import Foundation
import UIKit

class LocalizedButton: FancyButton {
    @IBInspectable var localizationKey: String?
    @IBInspectable var upperText: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if self.localizationKey == nil {
            assertionFailure("Translation key not set for \(self.title(for: .normal) ?? "")")
        }
        self.setTitle(self.upperText ? self.localizationKey?.localizedUpper : self.localizationKey?.localized)
    }
    
    private func setTitle(_ title: String?) {
        UIView.performWithoutAnimation {
            self.setTitle(title, for: .normal)
            self.layoutIfNeeded()
        }
    }
}
