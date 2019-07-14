import Foundation

public enum BackendError: Error {
    case unauthorized(rawResponse: Data?)
    case requestFailed(statusCode: Int?, rawResponse: Data?)
    case invalidStatusCode(statusCode: Int?, rawResponse: Data?)
    case requestPreparationFailed
}
