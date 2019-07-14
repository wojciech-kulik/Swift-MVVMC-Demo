import Foundation

struct ErrorResponse: Codable {
    var error: String?
    var errorDescription: String?
    var errorCode: String?
}
