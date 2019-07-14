import Foundation
import UIKit

@IBDesignable
class FancyButton: UIButton {
    
    override open var isEnabled: Bool {
        didSet {
            self.alpha = self.isEnabled ? 1.0 : 0.4
        }
    }
    
    override open var isHighlighted: Bool {
        didSet {
            self.setBackgroundColor()
        }
    }
    
    override var buttonType: UIButton.ButtonType {
        return UIButton.ButtonType.custom
    }
    
    override var contentEdgeInsets: UIEdgeInsets {
        get {
            return UIEdgeInsets(top: 9, left: 40, bottom: 9, right: 40)
        }
        
        set { }
    }
    
    var highlightedColor: UIColor {
        return Constants.mainColor
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUpView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setUpView()
    }
    
    private func setUpView() {
        self.cornerRadius = 10
        self.borderWidth = 1
        self.borderColor = self.tintColor
        
        self.setTitleColor(UIColor.white, for: .highlighted)
        self.alpha = self.isEnabled ? 1.0 : 0.3
        self.setBackgroundColor()
        
        self.layoutIfNeeded()
    }
    
    private func setBackgroundColor() {
        self.backgroundColor = self.isHighlighted
            ? self.highlightedColor
            : UIColor.clear
    }
}
