import Foundation
import UIKit

@IBDesignable class ButtonWithProgress: LocalizedButton {
    private let inProgressView = UIView()
    private let indicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
    
    var isInProgress: Bool = false {
        didSet {
            self.setInProgress()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUpView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setUpView()
    }
    
    private func setInProgress() {

        if self.isInProgress {
            self.inProgressView.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(self.inProgressView)
            self.inProgressView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            self.inProgressView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            self.inProgressView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            self.inProgressView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            
            self.indicatorView.startAnimating()
            return
        }
        
        self.indicatorView.stopAnimating()
        self.inProgressView.removeFromSuperview()
    }
    
    private func setUpView() {
        self.inProgressView.clipsToBounds = true
        self.inProgressView.layer.cornerRadius = 5
        self.inProgressView.backgroundColor = .white
        
        self.indicatorView.translatesAutoresizingMaskIntoConstraints = false
        self.inProgressView.addSubview(self.indicatorView)
        self.indicatorView.centerXAnchor.constraint(equalTo: self.inProgressView.centerXAnchor).isActive = true
        self.indicatorView.centerYAnchor.constraint(equalTo: self.inProgressView.centerYAnchor).isActive = true
        self.indicatorView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.indicatorView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        self.indicatorView.contentScaleFactor = 1.5
    }
}
