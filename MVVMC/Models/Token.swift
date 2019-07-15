import Foundation

struct Token: Codable, Equatable {
    let token: String
    let tokenType: String
    
    func getToken() -> String {
        return "\(tokenType) \(token)"
    }
}
