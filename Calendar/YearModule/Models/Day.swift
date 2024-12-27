struct Day {
    var number: Int
    var month: Int
    var year: Int
    lazy var date = "\(number).\(month).\(year)" //change it to identifier
    var isEvented: Bool = false
}

