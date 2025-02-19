protocol DayViewModelProtocol {
    var day: Day! { get set}
    var router: RouterProtocol! { get set }
    var coreDataManager: CoreDataManagerProtocol! { get set }
    var dateManager: DateManagerProtocol! { get set }
    var updateViewData: (() -> Void)? { get set }
    
}

final class DayViewModel: DayViewModelProtocol {
    var day: Day!
    var router: RouterProtocol!
    var coreDataManager: CoreDataManagerProtocol!
    var dateManager: DateManagerProtocol!
    public var updateViewData: (() -> Void)?
    
    func getEvents() -> [EventSettings.Event] {
        var events = [EventSettings.Event]()
        let allEvents = coreDataManager.getEvents()
        for event in allEvents {
            let date = dateManager.getStringOfDate(event.start)
            if date == day.date { events.append(event) }
        }
        events.sort() {$0.start < $1.end}
        return events
    }
    
}
