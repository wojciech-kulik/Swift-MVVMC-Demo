import Foundation

enum GeneralEndpoints {
    
    class FetchTranslations: BaseApiRequest<TranslationsResponse> {
        init() {
            super.init(resource: "translations")
        }
    }
}
