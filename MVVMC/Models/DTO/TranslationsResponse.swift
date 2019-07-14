import Foundation

typealias Languages = [String:[String:String]]

struct TranslationsResponse: Codable {
    let languages: Languages
}
