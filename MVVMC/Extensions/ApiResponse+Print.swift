import Foundation

extension ApiResponse {
    func print() {
        let responseJson = self.data != nil ? String(data: self.data!, encoding: .utf8) ?? "" : ""
        
        var message = "response: \(self.method) \(self.requestUrl) (status: \(self.statusCode ?? -1))"
        if responseJson.count > 0 {
            message.append("\n\n\(responseJson.prefix(1000))\n")
        }
        
        if self.error == nil {
            Logger.trace(message)
        }
    }
}
