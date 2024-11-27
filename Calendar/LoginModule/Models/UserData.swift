enum UserData {
    
    case initial
    case loading
    
    struct Data : Codable {
        var login: String
        var password: String
    }
}
