import Foundation

public class UrlSessionClient: HttpClient {
    
    let serverUrl: String
    var headers: [String:String]?
    
    private let session: URLSession = {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 30.0
        sessionConfig.timeoutIntervalForResource = 30.0
        
        return URLSession(configuration: sessionConfig)
    }()
    
    public init(serverUrl: String) {
        self.serverUrl = serverUrl
    }
    
    public func set(headers: [String:String]) {
        self.headers = headers
    }
    
    public func request(resource: String, method: HttpMethod, json: Data?, form: [String : String]?,
                        completion: @escaping (ApiResponse) -> Void) {
        
        if let json = json {
            DebugUtils.printRequest(method: method, payload: json)
        }
        
        guard let url = URL(string: "\(serverUrl)/\(resource)") else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.httpBody = json ?? self.getBody(from: form)
        self.headers?.forEach { urlRequest.setValue($0.1, forHTTPHeaderField: $0.0) }

        let task = self.session.dataTask(with: urlRequest) { data, response, error in
            let apiResponse = ApiResponse(
                success: error == nil,
                statusCode: (response as? HTTPURLResponse)?.statusCode,
                requestUrl: url.absoluteString,
                method: method,
                data: data,
                error: error)
            
            DispatchQueue.main.async {
                completion(apiResponse)
            }
        }
        task.resume()
    }
    
    private func getBody(from form: [String:String]?) -> Data? {
        let result = form?.map { (key, value) in
            guard let escapedValue = value.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return "" }
            return "\(key)=\(escapedValue)"
        }.joined(separator: "&")
        
        return result?.data(using: .utf8)
    }
}
