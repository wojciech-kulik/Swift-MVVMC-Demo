import Foundation

public enum RestApiStatusCodes: Int {
    case success = 200
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case conflict = 409
}
