import Foundation

public class Logger {
    enum LogLevel: Int {
        case none
        case error
        case info
        case debug
        case trace
    }
    
    static var logLevel = LogLevel.trace
    
    public static func debug(_ message: String) {
        guard logLevel.rawValue >= LogLevel.debug.rawValue else { return }
        log("\(getDate()) | DEBUG | \(message)")
    }
    
    public static func trace(_ message: String) {
        guard logLevel.rawValue >= LogLevel.trace.rawValue else { return }
        log("\(getDate()) | TRACE | \(message)")
    }
    
    public static func info(_ message: String) {
        guard logLevel.rawValue >= LogLevel.info.rawValue else { return }
        log("\(getDate()) | INFO | \(message)")
    }
    
    public static func error(_ message: String) {
        guard logLevel.rawValue >= LogLevel.error.rawValue else { return }
        log("\(getDate()) | ERROR | \(message)")
    }
    
    public static func error(_ message: String, error: Error?) {
        guard logLevel.rawValue >= LogLevel.error.rawValue else { return }
        if error != nil {
            log("\(getDate()) | ERROR | \(message)\n\(error!)")
        } else {
            log("\(getDate()) | ERROR | \(message)")
        }
    }
    
    private static func log(_ message: String) {
        #if DEBUG
        print(message)
        #endif
    }
    
    private static func getDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: Date())
    }
}
