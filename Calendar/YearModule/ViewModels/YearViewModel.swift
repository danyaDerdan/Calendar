protocol YearViewModelProtocol { //cделаем календарь пока что на 10 лет
    var dataManager: DataManagerProtocol! { get set }
    var router: RouterProtocol! { get set }
    func getDays(of year: Int) -> [[Day]] 
}

final class YearViewModel : YearViewModelProtocol {
    public var dataManager: DataManagerProtocol!
    public var router: RouterProtocol!
    
    public func getDays(of year: Int) -> [[Day]] {
        var days = [[Day]]()
        for i in 0..<12 {
            days.append([])
            for j in 0..<dataManager.getDaysInMonth(year: year, month: i) {
                days[i].append(Day(number: j+1, month: dataManager.getMonthName(month: i), year: year))
            }
        }
        return days
    }

}
