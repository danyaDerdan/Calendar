protocol DataManagerProtocol {
    func getDaysInMonth(year: Int, month: Int) -> Int
    func getMonthName(month: Int) -> String
    func getCellsStartIndex(year: Int) -> [Int]
    func getDayOfWeek(day: Int) -> String
    func getFirstDayOfYear(year: Int) -> Int
}

final class DataManager: DataManagerProtocol {
    private var contants: DataConstants = DataConstants()

    func getDaysInMonth(year: Int, month: Int) -> Int {
        return year%4==0 && month == 1 ? 29 : contants.daysInMonthes[month]
    }
    
    func getMonthName(month: Int) -> String {
        return contants.monthes[month]
    }
    
    func getCellsStartIndex(year: Int) -> [Int] {
        var cellsStartIndex = [contants.yearsStartsWith[year-2024]]
        for i in 1..<12 {
            cellsStartIndex.append((cellsStartIndex[i-1] + getDaysInMonth(year: year, month: i-1))%7)
        }
        return cellsStartIndex
    }
    
    func getDayOfWeek(day: Int) -> String {
        return contants.daysOfWeek[day]
    }
    
    func getFirstDayOfYear(year: Int) -> Int {
        return contants.yearsStartsWith[year-2024]
    }
}

