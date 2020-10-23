import Foundation
import RxSwift

class TranslationsService {
    private let dataManager: DataManager
    private let restClient: BackendRestClient
    
    private var translations: Languages?
    private(set) var currentLocale: Locale!
    
    init(dataManager: DataManager, restClient: BackendRestClient) {
        self.dataManager = dataManager
        self.restClient = restClient
        loadTranslations()
    }
    
    func loadTranslations() {
        translations = dataManager.get(key: SettingKey.translations, type: Languages.self) ?? loadDefaultTranslations()
        currentLocale = getLocale()
        Logger.info("Current locale: \(currentLocale.identifier)")
        Logger.info("Loaded languages: \(translations?.count ?? 0)")
    }
    
    func fetchTranslations() -> Completable {
        let request = restClient.request(GeneralEndpoints.FetchTranslations())
        
        return request
            .do(onSuccess: { [weak self] response in
                self?.dataManager.set(key: SettingKey.translations, value: response.languages)
                self?.loadTranslations()
            })
            .asCompletable()
    }
    
    func getCurrentTranslations() -> [String:String]? {
        let localeId = currentLocale.identifier.replacingOccurrences(of: "_", with: "-")
        let translations = self.translations?[localeId]
        return translations
    }
    
    private func getLocale() -> Locale {
        if let preferred = Locale.preferredLanguages
            .first(where: { translations?[$0.replacingOccurrences(of: "_", with: "-")] != nil }) {
            
            return Locale(identifier: preferred)
        }
        
        return Locale(identifier: "en_GB")
    }
    
    private func loadDefaultTranslations() -> Languages {
        if let json = FileUtils.loadTextFile(with: "translations", ofType: "json"),
            let data = json.data(using: .utf8),
            let translations = data.toObject(TranslationsResponse.self) {
            
            return translations.languages
        }
        
        return [:]
    }
}
