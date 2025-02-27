import Foundation

protocol DateManagerProtocol {
    func getDaysInMonth(year: Int, month: Int) -> Int
    func getMonthName(month: Int) -> String
    func getCellsStartIndex(year: Int) -> [Int]
    func getDayOfWeek(day: Int) -> String
    func getFirstDayOfYear(_ year: Int) -> Int
    func getFirstMonthOfYear(year: Int) -> Int
    func getStringOfDate(_ date: Date) -> String
    func getTimeOfDate(_ date: Date) -> String
    func isDayInWeekend(_ day: Day) -> Bool
    func getCurrentYear() -> Int
}

final class DateManager: DateManagerProtocol {
    private var constants: DateConstants = DateConstants()
    private var dateFormatter: DateFormatter = DateFormatter()

    func getDaysInMonth(year: Int, month: Int) -> Int {
        return year%4==0 && month == 1 ? 29 : constants.daysInMonthes[month]
    }
    
    func getMonthName(month: Int) -> String {
        return constants.monthes[month]
    }
    
    func getCellsStartIndex(year: Int) -> [Int] {
        var cellsStartIndex = [getFirstDayOfYear(year)]
        for i in 1..<12 {
            cellsStartIndex.append((cellsStartIndex[i-1] + getDaysInMonth(year: year, month: i-1))%7)
        }
        return cellsStartIndex
    }
    
    func getDayOfWeek(day: Int) -> String {
        return constants.daysOfWeek[day]
    }
    
    func getFirstDayOfYear(_ year: Int) -> Int {
        return Calendar.current.component(.weekday, from: DateComponents(calendar: .current, year: year, month: 1, day: 0).date ?? Date())-1
    }
    
    func getFirstMonthOfYear(year: Int) -> Int {
        dateFormatter.dateFormat = "M.yyyy"
        let arr = dateFormatter.string(from: Date()).split(separator: ".")
        let (month, curYear) = (Int(arr[0]) ?? 0, Int(arr[1]) ?? 0)
        if year > curYear { return 0 }
        if year == curYear {
            return month - 1
        }
        return 1
    }
    
    func getStringOfDate(_ date: Date) -> String {
        dateFormatter.dateFormat = "d.M.yyyy"
        return dateFormatter.string(from: date)
    }
    
    func getTimeOfDate(_ date: Date) -> String {
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
    
    func isDayInWeekend(_ day: Day) -> Bool {
        dateFormatter.dateFormat = "d.M.yyyy"
        guard let date = dateFormatter.date(from: "\(day.number).\(day.month).\(day.year)") else { return false }
        if Calendar.current.isDateInWeekend(date) { return true }
        return false
    }
    
    func getCurrentYear() -> Int {
        dateFormatter.dateFormat = "yyyy"
        return Int(dateFormatter.string(from: Date())) ?? 0
    }
    
}


