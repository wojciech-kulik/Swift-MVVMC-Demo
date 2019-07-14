import Foundation

struct ErrorMessage: Equatable {
    static func == (lhs: ErrorMessage, rhs: ErrorMessage) -> Bool {
        return lhs.title == rhs.title && lhs.message == rhs.message
    }
    
    let title: String
    let message: String
    let buttons: [String]
    let actions: [String:() -> Void]
}
