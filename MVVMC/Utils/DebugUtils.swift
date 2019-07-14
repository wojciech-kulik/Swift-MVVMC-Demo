import Foundation

public enum DebugUtils {
    public static func log(error: Error?) {
        if (error as NSError?)?.code == -1009 {
            Logger.error("Request failed - no internet connection")
        } else if (error as NSError?)?.code == -1001 {
            Logger.error("Request failed - timed out")
        } else {
            Logger.error("Error while fetching request: \(String(describing: error))")
        }
    }
    
    public static func printRequest(method: HttpMethod, payload: Data) {
        if let json = String(data: payload, encoding: .utf8) {
            let message = "\(String(describing: method).uppercased()) request PAYLOAD:\n\(json)\n"
            Logger.trace(message)
        }
    }
}
