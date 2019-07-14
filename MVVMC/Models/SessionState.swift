import Foundation

struct SessionState: Codable, Equatable {
    private(set) var token: Token
    private(set) var email: String
    private(set) var profile: MeResponse
    
    mutating func updateDetails(_ data: MeResponse) {
        self.profile = data
    }
}
