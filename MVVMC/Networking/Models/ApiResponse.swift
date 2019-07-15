import Foundation

struct VoidResponse: Codable { }

struct ApiResponse {
    let success: Bool
    let statusCode: Int?
    
    let requestUrl: String
    let method: HttpMethod
    
    let data: Data?
    let error: Error?
    
    init(success: Bool, statusCode: Int?, requestUrl: String, method: HttpMethod, data: Data?, error: Error?) {
        self.success = success
        self.statusCode = statusCode
        self.requestUrl = requestUrl
        self.method = method
        self.data = data
        self.error = error
    }
}
