protocol DayViewModelProtocol {
    var day: Day? { get set}
    var router: RouterProtocol? { get set }
    var coreDataManager: CoreDataManagerProtocol? { get set }
    var dateManager: DateManagerProtocol? { get set }
    var updateViewData: (() -> Void)? { get set }
    func getStringHour(_ hour: Int) -> String
}

final class DayViewModel: DayViewModelProtocol {
    var day: Day?
    var router: RouterProtocol?
    var coreDataManager: CoreDataManagerProtocol?
    var dateManager: DateManagerProtocol?
    var updateViewData: (() -> Void)?
    
    func getEvents() -> [EventSettings.Event] {
        var events = [EventSettings.Event]()
        guard let allEvents = coreDataManager?.getEvents() else { return events }
        for event in allEvents {
            guard let date = dateManager?.getStringOfDate(event.start) else { return events }
            if date == day?.date { events.append(event) }
        }
        events.sort() {$0.start < $1.end}
        return events
    }
    
    func getStringHour(_ hour: Int) -> String {
        return "\(hour > 9 ? String(hour) : "0" + String(hour)).00"
    }
    
}
