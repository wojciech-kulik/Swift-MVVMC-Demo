import Foundation

public protocol HttpClient {
    
    func set(headers: [String:String])
    
    func request(resource: String, method: HttpMethod, json: Data?, form: [String:String]?,
                 completion: @escaping (ApiResponse) -> Void)
}
