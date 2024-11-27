protocol LoginViewModelProtocol {
    var updateViewData: ((UserData) -> ())? { get set}
    var userData: UserData? {get set}
//    var router
//    var networkService
}

final class LoginViewModel: LoginViewModelProtocol {
    var updateViewData: ((UserData) -> ())?
    var userData: UserData?
    
    
    
}
