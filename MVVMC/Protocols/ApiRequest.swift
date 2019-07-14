import Foundation

protocol ApiRequest {
    var method: HttpMethod { get }
    var resource: String { get }
    var form: [String:String]? { get }
    var json: Data? { get }
    var expectedCode: Int { get }
    var contentType: String { get }
}
