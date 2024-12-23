protocol EventViewModelProtocol {
    var updateViewData : ((EventSettings) -> ())? { get set }
    var event: EventSettings.Event? { get }
    var yearViewModel: YearViewModelProtocol! { get set }
    var coreDataManager: CoreDataManagerProtocol! { get set }
    func validateData(name: String)
    func printSavedEvents()
    func reloadCells()
}

final class EventViewModel: EventViewModelProtocol {

    var updateViewData: ((EventSettings) -> ())?
    var event: EventSettings.Event?
    var coreDataManager: CoreDataManagerProtocol!
    var yearViewModel: YearViewModelProtocol!
    
    init() {
        updateViewData?(.invalid)
    }
    
    func validateData(name: String) {
        if !name.isEmpty {
            updateViewData?(.valid)
        }
        else {
            updateViewData?(.invalid)
        }
    }
    
    func printSavedEvents() {
        for i in coreDataManager.getEvents() {
            print(i)
        }
    }
    
    func reloadCells() {
        yearViewModel.updateViewData?()
    }
    
    
}
