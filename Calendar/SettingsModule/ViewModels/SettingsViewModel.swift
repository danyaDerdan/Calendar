import Foundation

protocol SettingsViewModelProtocol {
    var settings: Settings { get }
    var userDefaultsManager: UserDefaultsManagerProtocol? { get }
    func viewWillDissappear(name: String?, birthday: Date?, themeColor: String?, notificationSound: String?)
}

private struct Constants {
    static let colorValues: [String: Settings.Color] = ["blue": .blue, "green": .green, "pink": .pink, "purple": .purple]
    static let notificationSoundValues: [String: Settings.Sound] = ["default": .defaultSound, "critical": .critical]
}

final class SettingsViewModel: SettingsViewModelProtocol {
    lazy var settings = getData()
    var userDefaultsManager: UserDefaultsManagerProtocol?
    
    private func getData() -> Settings {
        let data = userDefaultsManager?.getSettings()
        settings = Settings(name: data?.name ?? "",
                                themeColor: Constants.colorValues[data?.themeColor ?? ""] ?? .blue,
                                birthday: data?.birthday ?? Date(),
                                notificationSound: Constants.notificationSoundValues[data?.notificationSound ?? ""] ?? .defaultSound,
                                avatar: .Cat)
        return settings
    }
    
    func viewWillDissappear(name: String?, birthday: Date?, themeColor: String?, notificationSound: String?) {
        userDefaultsManager?.saveSettings(name: name ?? "",
                                          birthday: birthday ?? Date(),
                                          themeColor: themeColor ?? "",
                                          notificationSound: notificationSound ?? "")
    }
    
    
}
