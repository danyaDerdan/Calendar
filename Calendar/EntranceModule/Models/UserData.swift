enum UserData {
    
    case initial
    case loading
    case valid(Data)
    case invalid(Data)
    case loginValid(Data)
    case passwordValid(Data)
    
    struct Data : Codable {
        var login: String
        var password: String
    }
}
