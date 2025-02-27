struct Day {
    var number: Int = 0
    var month: Int = 0
    var year: Int = 0
    lazy var date = "\(number).\(month).\(year)" //change it to identifier
    var isEvented: Bool = false
}

