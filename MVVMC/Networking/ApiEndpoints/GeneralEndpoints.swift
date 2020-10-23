import Foundation

enum GeneralEndpoints {
    class FetchTranslations: ApiRequest<TranslationsResponse> {
        init() {
            super.init(resource: "translations")
        }
    }
}
