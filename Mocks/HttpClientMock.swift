import Foundation

class HttpClientMock: HttpClient {
    func set(headers: [String : String]) {}
    
    func request(resource: String, method: HttpMethod, json: Data?,
                 completion: @escaping (ApiResponse) -> Void) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if resource == "login" {
                if let json = json, let request = json.toObject(SignInRequest.self),
                    request.username.count > 0,
                    request.password == "pass" {
                    completion(self.getResponse(200, resource, method, "{ \"accessToken\": \"12345678\", \"tokenType\": \"bearer\" }"))
                } else {
                    completion(self.getResponse(403, resource, method, "{ \"errorCode\": \"InvalidCredentials\" }"))
                }
            } else if resource == "me" {
                completion(self.getResponse(200, resource, method, "{ \"userId\": \"1234-2131-1234\" }"))
            } else if resource == "logout" {
                completion(self.getResponse(200, resource, method, ""))
            } else if resource == "translations" {
                completion(self.getResponse(200, resource, method, FileUtils.loadTextFile(with: "translations", ofType: "json")))
            } else if resource == "tasks" {
                completion(self.getResponse(200, resource, method, "[\"Study RxSwift\", \"Read about MVVM\", \"Read about Coordinators\", \"Create sample project\"]"))
            }
        }
    }
    
    private func getResponse(_ code: Int, _ resource: String, _ method: HttpMethod, _ data: String?) -> ApiResponse {
        return ApiResponse(
            success: true,
            statusCode: code,
            requestUrl: "https://mock/\(resource)",
            method: method,
            data: data?.data(using: .utf8),
            error: nil)
    }
}
