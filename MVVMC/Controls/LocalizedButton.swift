import Foundation
import UIKit

class LocalizedButton: FancyButton {
    @IBInspectable var localizationKey: String?
    @IBInspectable var upperText: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if localizationKey == nil {
            assertionFailure("Translation key not set for \(title(for: .normal) ?? "")")
        }
        setTitle(upperText ? localizationKey?.localizedUpper : localizationKey?.localized)
    }
    
    private func setTitle(_ title: String?) {
        UIView.performWithoutAnimation {
            setTitle(title, for: .normal)
            layoutIfNeeded()
        }
    }
}
