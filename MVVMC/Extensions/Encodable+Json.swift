import Foundation

extension Encodable {
    func toJson() -> Data? {
        return try? Json.encoder.encode(self)
    }
}
