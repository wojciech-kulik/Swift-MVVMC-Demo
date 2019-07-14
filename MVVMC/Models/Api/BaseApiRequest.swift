import Foundation

struct VoidResponse: Codable { }

class BaseApiRequest<T:Codable>: ApiRequest {
    
    let method: HttpMethod
    let resource: String
    let expectedCode: Int
    let form: [String:String]?
    let json: Data?
    let contentType: String
    
    init(resource: String,
         method: HttpMethod = .get,
         expectedCode: Int = 200,
         form: [String:String]? = nil,
         json: Data? = nil,
         contentType: String = "application/json") {
        
        self.resource = resource
        self.method = method
        self.expectedCode = expectedCode
        self.form = form
        self.json = json
        self.contentType = contentType
    }
}
