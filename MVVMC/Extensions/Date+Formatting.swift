import Foundation

extension Date {
    
    func format(dateStyle: DateFormatter.Style = .long, timeStyle: DateFormatter.Style = .none) -> String {
        return self.format(dateStyle: dateStyle, timeStyle: timeStyle, locale: LocalizationUtils.currentLocale)
    }
    
    func format(dateStyle: DateFormatter.Style = .long, timeStyle: DateFormatter.Style = .none, locale: Locale) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = locale
        dateFormatter.dateStyle = dateStyle
        dateFormatter.timeStyle = timeStyle
        return dateFormatter.string(from: self)
    }
}

