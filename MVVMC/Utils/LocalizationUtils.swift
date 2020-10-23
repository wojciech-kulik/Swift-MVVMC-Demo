import Foundation

enum LocalizationUtils {
    private static var translationsService = AppDelegate.container.resolve(TranslationsService.self)!
    
    static var currentLocale: Locale {
        return translationsService.currentLocale
    }
    
    static func localize(key: String) -> String {
        return translationsService.getCurrentTranslations()?[key] ?? key
    }
}
