import Foundation

struct AlertMessage: Equatable {
    static func == (lhs: AlertMessage, rhs: AlertMessage) -> Bool {
        return lhs.title == rhs.title && lhs.message == rhs.message
    }
    
    let title: String
    let message: String
    let buttons: [String]
    let actions: [String:() -> Void]
}
