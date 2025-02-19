protocol EntranceViewModelProtocol {
    var updateViewData: ((UserData) -> ())? { get set}
    var router: RouterProtocol? {get set}
    func validateData(data: UserData.Data)
}

final class RegisterViewModel: EntranceViewModelProtocol {
    var updateViewData: ((UserData) -> ())?
    var router: RouterProtocol?
    
    init() {
        updateViewData?(.initial)
    }
    
func validateData(data: UserData.Data) {
        switch (isValidLogin(login: data.login), isValidPassword(password: data.password)) {
        case (true, true):
            updateViewData?(.valid(data))
        case (false, false):
            updateViewData?(.invalid(data))
        case (true, false):
            updateViewData?(.loginValid(data))
        case (false, true):
            updateViewData?(.passwordValid(data))
        }
    }
}



private extension RegisterViewModel {
    func isValidLogin(login: String) -> Bool {
//        if login.ЗАНЯТ { return false}
        if 5 < login.count && login.count < 20 { return true}
        return false
    }
    
    func isValidPassword(password: String) -> Bool {
        var result = false
        if 5 > password.count && password.count < 20 { return false}
        for i in "#$%&'()*+" {
            if password.contains(i) { result = true }
        }
        if result == false { return result}
        result = false
        for i in "abcdefghijklmnopqrstuvwxyz" {
            if password.contains(i) { return true }
        }
        return result
    }
}
