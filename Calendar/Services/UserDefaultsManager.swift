import Foundation

private struct Keys {
    static let nameKey = "name"
    static let birthdayKey = "birthday"
    static let themeColorKey = "themeColor"
    static let notificationSoundKey = "notificationSound"
}

protocol UserDefaultsManagerProtocol {
    func saveSettings(name: String, birthday: Date, themeColor: String, notificationSound: String)
    func getSettings() -> (name: String, birthday: Date, themeColor: String, notificationSound: String)
}

final class UserDefaultsManager: UserDefaultsManagerProtocol {
    
    let userDefaults = UserDefaults.standard
    
    func saveSettings(name: String, birthday: Date, themeColor: String, notificationSound: String) {
        userDefaults.set(name, forKey: Keys.nameKey)
        userDefaults.set(birthday, forKey: Keys.birthdayKey)
        userDefaults.set(themeColor, forKey: Keys.themeColorKey)
        userDefaults.set(notificationSound, forKey: Keys.notificationSoundKey)
    }
    
    func getSettings() -> (name: String, birthday: Date, themeColor: String, notificationSound: String) {
        let name = userDefaults.string(forKey: Keys.nameKey) ?? ""
        let birthday = userDefaults.object(forKey: Keys.birthdayKey) as? Date ?? Date()
        let themeColor = userDefaults.string(forKey: Keys.themeColorKey) ?? ""
        let notificationSound = userDefaults.string(forKey: Keys.notificationSoundKey) ?? ""
        return (name, birthday, themeColor, notificationSound)
    }
    
}
