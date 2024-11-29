import UIKit

protocol BuilderProtocol {
    func createLaunchModule(router: RouterProtocol) -> UIViewController
    func createLoginModule(router: RouterProtocol) -> UIViewController
    func createRegisterModule(router: RouterProtocol) -> UIViewController
}

final class Builder: BuilderProtocol {
    
    func createLaunchModule(router: RouterProtocol) -> UIViewController {
        let view = LaunchViewController()
        let viewModel = LaunchViewModel()
        viewModel.router = router
        view.viewModel = viewModel
        return view
    }
    
    func createLoginModule(router: RouterProtocol) -> UIViewController {
        return UIViewController()
    }
    
    func createRegisterModule(router: RouterProtocol) -> UIViewController {
        let view = EntranceViewController()
        let viewModel = RegisterViewModel()
        viewModel.router = router
        view.buttonTitle = "Register"
        view.viewModel = viewModel
        return view
    }
}

