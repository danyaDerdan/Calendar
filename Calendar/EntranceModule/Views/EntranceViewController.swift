import UIKit

private struct Constants {
    static let buttonTitleFont = UIFont.boldSystemFont(ofSize: 30)
    static let buttonCornerRadius: CGFloat = 30
    static let verticalInset: CGFloat = 60
    static let buttonWidthMultiplier: CGFloat = 0.8
    static let buttonHeight: CGFloat = 80
}

final class EntranceViewController: UIViewController {
    
    var viewModel: EntranceViewModelProtocol?
    var buttonTitle: String = "Enter"
    lazy var button = createButton(title: buttonTitle)
    private lazy var textFieldsView = EntranceView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpView()
        updateView()
        hideKeybordWhenTappedAround()
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    func updateView() {
        viewModel?.updateViewData = { [weak self] (viewData) in
            self?.textFieldsView.viewData = viewData
            switch viewData {
            case .valid:
                self?.viewModel?.router?.showYearModule()
            default:
                break
            }
        }
    }
}

extension EntranceViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeyboard()
        return true
    }
}

private extension EntranceViewController {
    
    func setUpView() {
        textFieldsView = EntranceView()
        view.addSubview(textFieldsView)
        textFieldsView.bounds = view.bounds
        textFieldsView.center = view.center
        textFieldsView.setUpUI()
    }
    
    func createButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.backgroundColor = .systemPurple
        button.titleLabel?.tintColor = .white
        button.titleLabel?.font = Constants.buttonTitleFont
        button.layer.cornerRadius = Constants.buttonCornerRadius
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.verticalInset),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: Constants.buttonWidthMultiplier),
            button.heightAnchor.constraint(equalToConstant: Constants.buttonHeight)
        ])
        textFieldsView.loginTextField.delegate = self
        return button
    }
    
    func hideKeybordWhenTappedAround() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGestureRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func buttonTapped() {
        let (login, password) = (textFieldsView.loginTextField.text ?? "", textFieldsView.passwordTextField.text ?? "")
        viewModel?.validateData(data: UserData.Data(login: login, password: password))
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}

