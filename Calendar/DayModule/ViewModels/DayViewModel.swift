protocol DayViewModelProtocol {
    var day: Day? { get set}
    var updateViewData: ((DayViewState) -> Void)? { get set }
    var hours: [Hour]? { get }
    var events: [EventSettings.Event]? { get }
    func getEvents() -> [EventSettings.Event]
    func buttonTapped(tag: Int)
    func viewDidLoad()
}

final class DayViewModel: DayViewModelProtocol {
    var router: RouterProtocol?
    var coreDataManager: CoreDataManagerProtocol?
    var dateManager: DateManagerProtocol?
    var day: Day?
    var updateViewData: ((DayViewState) -> Void)?
    var hours: [Hour]?
    var events: [EventSettings.Event]?
    
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
    
    func buttonTapped(tag: Int) {
        router?.showEventModule(event: getEvents()[tag])
    }
    
    func viewDidLoad() {
        sendViewData()
    }
    
    func sendViewData() {
        if getEvents().count > 0 {
            updateViewData?(.data(data: DayViewState.ViewData(events: getEvents())))
        }
        else {
            updateViewData?(.error)
        }
    }
    
    
}
