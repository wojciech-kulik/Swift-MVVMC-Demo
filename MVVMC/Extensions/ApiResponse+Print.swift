import Foundation

extension ApiResponse {
    func print() {
        let responseJson = data != nil ? String(data: data!, encoding: .utf8) ?? "" : ""
        
        var message = "response: \(method) \(requestUrl) (status: \(statusCode ?? -1))"
        if responseJson.count > 0 {
            message.append("\n\n\(responseJson.prefix(1000))\n")
        }
        
        if error == nil {
            Logger.debug(message)
        }
    }
}
