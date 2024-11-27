import UIKit

protocol RouterProtocol {
    var navigationController: UINavigationController { get set }
    var builder: BuilderProtocol { get set }
    
    func ititialVC()
    func popToRoot()
    func showLoginModule()
}

final class Router: RouterProtocol {
    
    var builder: BuilderProtocol
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController, builder: BuilderProtocol) {
        self.navigationController = navigationController
        self.builder = builder
    }
    
    func ititialVC() {
        navigationController.viewControllers = [builder.createLaunchModule(router: self)]
    }
    
    func showLoginModule() { //Redo funcs to every module using builder
        navigationController.pushViewController(builder.createLoginModule(router: self), animated: true)
    }
    
    func popToRoot() {
        navigationController.popToRootViewController(animated: true)
    }
}
