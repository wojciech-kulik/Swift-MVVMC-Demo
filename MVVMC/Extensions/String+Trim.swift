import Foundation

extension String {
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
    
    func hasNonEmptyValue() -> Bool {
        return self.trim() != ""
    }
}
