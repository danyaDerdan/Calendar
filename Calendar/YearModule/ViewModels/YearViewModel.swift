protocol YearViewModelProtocol { //cделаем календарь пока что на 10 лет
    var dataManager: DataManagerProtocol! { get set }
    var router: RouterProtocol! { get set }
    var updateViewData: (() -> Void)? { get set }
    var coreDataManager: CoreDataManagerProtocol! { get set }
    func getDays(of year: Int) -> [[Day]]
}

final class YearViewModel : YearViewModelProtocol {
    public var dataManager: DataManagerProtocol!
    public var router: RouterProtocol!
    public var coreDataManager: CoreDataManagerProtocol!
    public var updateViewData: (() -> Void)?
    
    public func getDays(of year: Int) -> [[Day]] {
        var days = [[Day]]()
        let firstMonth = dataManager.getFirstMonthOfYear(year: year)
        for i in firstMonth..<12 {
            days.append([])
            for j in 0..<dataManager.getDaysInMonth(year: year, month: i) {
                days[i-firstMonth].append(Day(number: j+1, month: i+1, year: year, isEvented: isDayEvented(day: j+1, month: i+1, year: year)))
            }
        }
        return days
    }
    
    private func isDayEvented(day: Int, month: Int, year: Int) -> Bool {
        let events = coreDataManager.getEvents()
        for event in events {
            if dataManager.getStringOfDate(event.start) == "\(day).\(month).\(year)" { return true }
            
        }
        return false
    }

}
