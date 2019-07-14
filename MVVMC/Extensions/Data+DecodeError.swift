import Foundation

extension Data {
    
    func decodeError() -> ErrorResponse? {
        return self.toObject(ErrorResponse.self)
    }
}
