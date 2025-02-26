import UIKit

protocol BuilderProtocol {
    func createLaunchModule(router: RouterProtocol) -> UIViewController
    func createLoginModule(router: RouterProtocol) -> UIViewController
    func createRegisterModule(router: RouterProtocol) -> UIViewController
    func createYearModule(router: RouterProtocol) -> UIViewController
    func createEventModule(router: RouterProtocol, event: EventSettings.Event?) -> UIViewController
    func createDayModel(router: RouterProtocol, day: Day) -> UIViewController
}

final class Builder: BuilderProtocol {
    var yearViewModel = YearViewModel()
    var dayViewModel = DayViewModel()
    
    func createLaunchModule(router: RouterProtocol) -> UIViewController {
        let viewModel = LaunchViewModel()
        let view = LaunchViewController()
        viewModel.router = router
        view.viewModel = viewModel
        return view
    }
    
    func createLoginModule(router: RouterProtocol) -> UIViewController {
        return UIViewController()
    }
    
    func createRegisterModule(router: RouterProtocol) -> UIViewController {
        let viewModel = RegisterViewModel()
        let view = EntranceViewController()
        viewModel.router = router
        view.buttonTitle = "Register"
        view.viewModel = viewModel
        return view
    }
    
    func createYearModule(router: RouterProtocol) -> UIViewController {
        let viewModel = yearViewModel
        let view = YearViewController()
        let dataManager = DateManager()
        let coreDataManager = CoreDataManager()
        viewModel.router = router
        viewModel.dateManager = dataManager
        viewModel.coreDataManager = coreDataManager
        view.viewModel = viewModel
        return view
    }
    
    func createEventModule(router: RouterProtocol, event: EventSettings.Event?) -> UIViewController {
        let viewModel = EventViewModel()
        let coreDataManager = CoreDataManager()
        let notificationManager = NotificationManager()
        viewModel.coreDataManager = coreDataManager
        viewModel.notificationManager = notificationManager
        viewModel.yearViewModel = yearViewModel
        viewModel.dayViewModel = dayViewModel
        viewModel.event = event
        let view = EventViewController()
        view.viewModel = viewModel
        return view
    }
    
    func createDayModel(router: RouterProtocol, day: Day) -> UIViewController {
        let viewModel = dayViewModel
        let coreDataManager = CoreDataManager()
        let dateManager = DateManager()
        viewModel.day = day
        viewModel.router = router
        viewModel.coreDataManager = coreDataManager
        viewModel.dateManager = dateManager
        let view = DayViewController()
        view.viewModel = viewModel
        return view
    }
}

