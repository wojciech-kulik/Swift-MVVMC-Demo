import Foundation

struct Token: Codable, Equatable {
    let token: String
    let tokenType: String
    
    func getTokenHeader() -> String {
        return "\(tokenType) \(token)"
    }
}
