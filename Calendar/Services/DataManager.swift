import Foundation

protocol DataManagerProtocol {
    func getDaysInMonth(year: Int, month: Int) -> Int
    func getMonthName(month: Int) -> String
    func getCellsStartIndex(year: Int) -> [Int]
    func getDayOfWeek(day: Int) -> String
    func getFirstDayOfYear(year: Int) -> Int
    func getFirstMonthOfYear(year: Int) -> Int
    func getStringOfDate(_ date: Date) -> String
    func getTimeOfDate(_ date: Date) -> String
}

final class DataManager: DataManagerProtocol {
    private var constants: DataConstants = DataConstants()

    func getDaysInMonth(year: Int, month: Int) -> Int {
        return year%4==0 && month == 1 ? 29 : constants.daysInMonthes[month]
    }
    
    func getMonthName(month: Int) -> String {
        return constants.monthes[month]
    }
    
    func getCellsStartIndex(year: Int) -> [Int] {
        var cellsStartIndex = [constants.yearsStartsWith[year-2024]]
        for i in 1..<12 {
            cellsStartIndex.append((cellsStartIndex[i-1] + getDaysInMonth(year: year, month: i-1))%7)
        }
        return cellsStartIndex
    }
    
    func getDayOfWeek(day: Int) -> String {
        return constants.daysOfWeek[day]
    }
    
    func getFirstDayOfYear(year: Int) -> Int {
        return constants.yearsStartsWith[year-2024]
    }
    
    func getFirstMonthOfYear(year: Int) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M.yyyy"
        let arr = dateFormatter.string(from: Date()).split(separator: ".")
        let (month, curYear) = (Int(arr[0])!, Int(arr[1])!)
        if year > curYear { return 0 }
        if year == curYear {
            return month - 1
        }
        return 1
    }
    
    func getStringOfDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d.M.yyyy"
        return dateFormatter.string(from: date)
    }
    
    func getTimeOfDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
}


