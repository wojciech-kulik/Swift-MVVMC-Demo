import Foundation

extension String {
    func trim() -> String {
        return trimmingCharacters(in: CharacterSet.whitespaces)
    }
    
    func hasNonEmptyValue() -> Bool {
        return trim() != ""
    }
}
