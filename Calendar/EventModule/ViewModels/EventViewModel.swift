import Foundation

protocol EventViewModelProtocol {
    var updateViewData : ((EventSettings) -> ())? { get set }
    var event: EventSettings.Event? { get }
    var yearViewModel: YearViewModelProtocol? { get set }
    var dayViewModel: DayViewModelProtocol? { get set }
    var coreDataManager: CoreDataManagerProtocol? { get set }
    var notificationManager: NotificationManagerProtocol? { get set }
    func validateData(name: String)
    func reloadViews()
    func saveEvent(name: String?, description: String?, start: Date, end: Date, notification: Bool)
}

final class EventViewModel: EventViewModelProtocol {

    var updateViewData: ((EventSettings) -> ())?
    var event: EventSettings.Event?
    var coreDataManager: CoreDataManagerProtocol?
    var yearViewModel: YearViewModelProtocol?
    var dayViewModel: DayViewModelProtocol?
    var notificationManager: NotificationManagerProtocol?
    
    func validateData(name: String) {
        if !name.isEmpty {
            updateViewData?(.valid)
        }
        else {
            updateViewData?(.invalid)
        }
    }
    
    func reloadViews() {
        yearViewModel?.updateViewData?()
        dayViewModel?.viewDidLoad()
    }
    
    func saveEvent(name: String?, description: String?, start: Date, end: Date, notification: Bool) {
        if let event  { coreDataManager?.deleteEvent(event: event) }
        let newEvent = EventSettings.Event(name: name ?? "",
                                           description: description ?? "",
                                           start: start,
                                           end: end,
                                           notification: notification)
        coreDataManager?.saveEvent(newEvent)
        reloadViews()
        notificationManager?.addNotification(event: newEvent)
    }
    
    
}
