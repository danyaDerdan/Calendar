import Foundation

protocol SettingsViewModelProtocol {
    var settings: Settings { get }
    var userDefaultsManager: UserDefaultsManagerProtocol? { get }
    func viewWillDissappear(name: String?, birthday: Date?, themeColor: String?, notificationSound: String?)
    func fetchData()
}

private struct Constants {
    static let colorValues: [String: Settings.Color] = ["blue": .blue, "green": .green, "pink": .pink, "purple": .purple]
    static let notificationSoundValues: [String: Settings.Sound] = ["default": .defaultSound, "critical": .critical]
}

final class SettingsViewModel: SettingsViewModelProtocol {
    lazy var settings = getData()
    var userDefaultsManager: UserDefaultsManagerProtocol?
    var networkService: NetworkServiceProtocol?
    
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
    
    func fetchData() {
        networkService?.fetchImage(stringUrl: "https://avatars.githubusercontent.com/u/110595066?s=400&u=676bfb3c64786190b0553da0f1e4592db579b49c&v=4",
                                   completion: { result in
            switch result {
            case .success(let data): break
            case .failure(let error): break
            }
        })
    }
    
}
