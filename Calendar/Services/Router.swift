import UIKit

protocol RouterProtocol {
    var navigationController: UINavigationController { get set }
    var builder: BuilderProtocol { get set }
    
    func ititialVC()
    func popToRoot()
    func showLoginModule()
    func showRegisterModule()
    func showYearModule()
    func showEventModule(event: EventSettings.Event?, dayViewModel: DayViewModelProtocol?, yearViewModel: YearViewModelProtocol?)
    func showDayModule(with day: Day, yearViewModel: YearViewModelProtocol?)
}

final class Router: RouterProtocol {
    
    var builder: BuilderProtocol
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController, builder: BuilderProtocol) {
        self.navigationController = navigationController
        self.builder = builder
    }
    
    func ititialVC() {
        navigationController.viewControllers = [builder.createYearModule(router: self)]
    }
    
    func popToRoot() {
        navigationController.popToRootViewController(animated: true)
    }
    
    func showLoginModule() { 
        navigationController.pushViewController(builder.createLoginModule(router: self), animated: true)
    }
    
    func showRegisterModule() {
        navigationController.pushViewController(builder.createRegisterModule(router: self), animated: true)
    }
    
    func showYearModule() {
        navigationController.pushViewController(builder.createYearModule(router: self), animated: true)
    }
    
    func showEventModule(event: EventSettings.Event?, dayViewModel: DayViewModelProtocol?, yearViewModel: YearViewModelProtocol?) {
        navigationController.present(builder.createEventModule(router: self, event: event, dayViewModel: dayViewModel, yearViewModel: yearViewModel), animated: true)
    }
    func showDayModule(with day: Day, yearViewModel: YearViewModelProtocol?) {
        navigationController.pushViewController(builder.createDayModel(router: self, day: day, yearViewModel: yearViewModel), animated: true)
    }
}
