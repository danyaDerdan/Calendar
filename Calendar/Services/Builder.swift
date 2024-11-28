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
        return LoginViewController()
    }
    
    func createRegisterModule(router: any RouterProtocol) -> UIViewController {
        return UIViewController()
    }
}

