import Foundation

class UserDataManager: DataManager {
    private var data: [String:String]
    
    init() {
        data = UserDefaults.standard
            .data(forKey: "data")?
            .toObject([String:String].self) ?? [:]
        
        Logger.info("Loaded user data: \(data.count) keys")
    }
    
    func get<T>(key: String, type: T.Type) -> T? where T : Codable {
        let result = data[key]?.data(using: .utf8)?.toObject(type)
        return result
    }
    
    func get(key: String) -> String? {
        return data[key]
    }
    
    func set<T>(key: String, value: T?) where T : Codable {
        if let json = value?.toJson() {
            data[key] = String(data: json, encoding: .utf8)
            synchronize()
        }
    }
    
    func remove(key: String) {
        data.removeValue(forKey: key)
        synchronize()
    }
    
    func clear() {
        data.removeAll()
        synchronize()
    }
    
    private func synchronize() {
        UserDefaults.standard.set(data.toJson(), forKey: "data")
    }
}
