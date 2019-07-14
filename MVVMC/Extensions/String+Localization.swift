import Foundation

extension String {
    var localized: String {
        return LocalizationUtils.localize(key: self)
    }
    
    var localizedUpper: String {
        return LocalizationUtils.localize(key: self).uppercased()
    }
}
