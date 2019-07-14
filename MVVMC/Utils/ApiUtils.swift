import Foundation

enum ApiUtils {
    
    static func getApiErrorMessage(from error: Error) -> String? {
        if case BackendError.requestFailed(_, let rawResponse) = error,
            let errorDescription = rawResponse?.decodeError()?.errorCode {
            return errorDescription
        } else if case BackendError.unauthorized(let rawResponse) = error,
            let errorDescription = rawResponse?.decodeError()?.errorCode {
            return errorDescription
        } else if case BackendError.invalidStatusCode(_, let rawResponse) = error,
            let errorDescription = rawResponse?.decodeError()?.errorCode {
            return errorDescription
        }
        
        return nil
    }
}
