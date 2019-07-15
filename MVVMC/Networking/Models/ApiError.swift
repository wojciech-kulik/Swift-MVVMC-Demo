import Foundation

enum ApiError: Error {
    case requestFailed(statusCode: Int?, response: Data?)
}
