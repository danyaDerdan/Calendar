protocol DayViewModelProtocol {
    var day: Day? { get set}
    var router: RouterProtocol? { get set }
    var coreDataManager: CoreDataManagerProtocol? { get set }
    var dateManager: DateManagerProtocol? { get set }
    var updateViewData: (() -> Void)? { get set }
    var hours: [Hour]? { get }
    func getEvents() -> [EventSettings.Event]
}

final class DayViewModel: DayViewModelProtocol {
    var day: Day?
    var router: RouterProtocol?
    var coreDataManager: CoreDataManagerProtocol?
    var dateManager: DateManagerProtocol?
    var updateViewData: (() -> Void)?
    var hours: [Hour]?
    
    init() {
        hours = getHours()
    }
    
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
    
    private func getStringHour(_ hour: Int) -> String {
        return "\(hour > 9 ? String(hour) : "0" + String(hour)).00"
    }
    
    private func getHours() -> [Hour] {
        var hours: [Hour] = []
        for i in 0..<24 {
            hours.append(Hour(text: getStringHour(i)))
        }
        return hours
    }
    
}
