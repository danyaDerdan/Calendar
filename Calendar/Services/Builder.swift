import UIKit

protocol BuilderProtocol {
    func createLaunchModule(router: RouterProtocol) -> UIViewController
    func createLoginModule(router: RouterProtocol) -> UIViewController
    func createRegisterModule(router: RouterProtocol) -> UIViewController
    func createYearModule(router: RouterProtocol) -> UIViewController
    func createEventModule(router: RouterProtocol) -> UIViewController
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
    
    func createYearModule(router: RouterProtocol) -> UIViewController {
        let view = YearViewController()
        let viewModel = YearViewModel()
        let dataManager = DataManager()
        viewModel.router = router
        viewModel.dataManager = dataManager
        view.viewModel = viewModel
        return view
    }
    
    func createEventModule(router: RouterProtocol) -> UIViewController {
        let viewModel = EventViewModel()
        let coreDataManager = CoreDataManager()
        viewModel.coreDataManager = coreDataManager
        let view = EventViewController()
        view.viewModel = viewModel
        return view
    }
}

