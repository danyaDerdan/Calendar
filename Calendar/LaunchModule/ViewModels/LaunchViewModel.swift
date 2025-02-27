protocol LaunchViewModelProtocol {
    var router: RouterProtocol? { get set }
}

final class LaunchViewModel : LaunchViewModelProtocol {
    var router: RouterProtocol?
}
