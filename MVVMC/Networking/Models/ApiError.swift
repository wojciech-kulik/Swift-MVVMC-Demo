import Foundation

public enum ApiError: Error {
    case requestFailed(statusCode: Int?, response: Data?)
    case sessionExpired
}
