protocol SettingsViewModelProtocol {
    var settings: Settings? { get }
    var router: RouterProtocol? { get }
}

final class SettingsViewModel: SettingsViewModelProtocol {
    var settings: Settings?
    var router: RouterProtocol?
    
    
    
}
