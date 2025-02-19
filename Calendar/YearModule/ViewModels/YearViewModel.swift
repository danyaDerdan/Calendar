protocol YearViewModelProtocol {
    var dateManager: DateManagerProtocol? { get set }
    var router: RouterProtocol? { get set }
    var updateViewData: (() -> Void)? { get set }
    var coreDataManager: CoreDataManagerProtocol? { get set }
    func getDays(of year: Int) -> [[Day]]
}

final class YearViewModel : YearViewModelProtocol {
    public var dateManager: DateManagerProtocol?
    public var router: RouterProtocol?
    public var coreDataManager: CoreDataManagerProtocol?
    public var updateViewData: (() -> Void)?
    
    public func getDays(of year: Int) -> [[Day]] {
        var days = [[Day]]()
        for month in 0..<12 {
            days.append([])
            for day in 0..<(dateManager?.getDaysInMonth(year: year, month: month) ?? 0) {
                days[month].append(Day(number: day+1, month: month+1, year: year, isEvented: isDayEvented(day: day+1, month: month+1, year: year)))
            }
        }
        return days
    }
    
    private func isDayEvented(day: Int, month: Int, year: Int) -> Bool {
        guard let events = coreDataManager?.getEvents() else { return false }
        for event in events {
            if dateManager?.getStringOfDate(event.start) == "\(day).\(month).\(year)" { return true }
        }
        return false
    }
    
    

}
