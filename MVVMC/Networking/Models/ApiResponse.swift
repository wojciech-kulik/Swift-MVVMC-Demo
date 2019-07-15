import Foundation

public struct ApiResponse {
    public let success: Bool
    public let statusCode: Int?
    
    public let requestUrl: String
    public let method: HttpMethod
    
    public let data: Data?
    public let error: Error?
    
    public init(success: Bool, statusCode: Int?, requestUrl: String, method: HttpMethod, data: Data?, error: Error?) {
        self.success = success
        self.statusCode = statusCode
        self.requestUrl = requestUrl
        self.method = method
        self.data = data
        self.error = error
    }
}
