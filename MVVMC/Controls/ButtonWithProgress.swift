import Foundation
import UIKit

@IBDesignable class ButtonWithProgress: LocalizedButton {
    private let inProgressView = UIView()
    private let indicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
    
    var isInProgress: Bool = false {
        didSet {
            setInProgress()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUpView()
    }
    
    private func setInProgress() {
        if isInProgress {
            inProgressView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(inProgressView)
            inProgressView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            inProgressView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            inProgressView.topAnchor.constraint(equalTo: topAnchor).isActive = true
            inProgressView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            
            indicatorView.startAnimating()
            return
        }
        
        indicatorView.stopAnimating()
        inProgressView.removeFromSuperview()
    }
    
    private func setUpView() {
        inProgressView.clipsToBounds = true
        inProgressView.layer.cornerRadius = 5
        inProgressView.backgroundColor = .white
        
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        inProgressView.addSubview(indicatorView)
        indicatorView.centerXAnchor.constraint(equalTo: inProgressView.centerXAnchor).isActive = true
        indicatorView.centerYAnchor.constraint(equalTo: inProgressView.centerYAnchor).isActive = true
        indicatorView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        indicatorView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        indicatorView.contentScaleFactor = 1.5
    }
}
