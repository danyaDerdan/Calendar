import UIKit

final class EntranceView: UIView {
    
    var viewData: UserData = .initial {
        didSet {
            setNeedsLayout()
        }
    }
    
    lazy var loginTextField = createTextField(placeholder: "Login")
    lazy var passwordTextField = createTextField(placeholder: "Password")
    lazy var invalidLoginLabel = createErrorLabel(text: "Логин должен содержать от 6 до 20 символов")
    lazy var invalidPasswordLabel = createErrorLabel(text: "Пароль должен содержать от 6 до 20 символов, хотя бы одну латинскую букву и хотя бы один специальный симовл")
    lazy var stackView = createStackView()
    
    override func layoutSubviews() {
        switch viewData {
        case .initial, .loading:
            loginTextField.layer.borderColor = UIColor.systemGray.cgColor
            passwordTextField.layer.borderColor = UIColor.systemGray.cgColor
            invalidLoginLabel.textColor = .systemRed.withAlphaComponent(0)
            invalidPasswordLabel.textColor = .systemRed.withAlphaComponent(0)
        case .valid:
            loginTextField.layer.borderColor = UIColor.systemGreen.cgColor
            passwordTextField.layer.borderColor = UIColor.systemGreen.cgColor
            invalidLoginLabel.textColor = .systemRed.withAlphaComponent(0)
            invalidPasswordLabel.textColor = .systemRed.withAlphaComponent(0)
        case .invalid:
            loginTextField.layer.borderColor = UIColor.systemRed.cgColor
            passwordTextField.layer.borderColor = UIColor.systemRed.cgColor
            invalidLoginLabel.textColor = .systemRed.withAlphaComponent(1)
            invalidPasswordLabel.textColor = .systemRed.withAlphaComponent(1)
        case .loginValid:
            loginTextField.layer.borderColor = UIColor.systemGreen.cgColor
            passwordTextField.layer.borderColor = UIColor.systemRed.cgColor
            invalidLoginLabel.textColor = .systemRed.withAlphaComponent(0)
            invalidPasswordLabel.textColor = .systemRed.withAlphaComponent(1)
        case .passwordValid:
            loginTextField.layer.borderColor = UIColor.systemRed.cgColor
            passwordTextField.layer.borderColor = UIColor.systemGreen.cgColor
            invalidLoginLabel.textColor = .systemRed.withAlphaComponent(1)
            invalidPasswordLabel.textColor = .systemRed.withAlphaComponent(0)
        }
    }
}




extension EntranceView {
    
    func createTextField(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.lightGray.cgColor
        return textField
    }
    
    func createStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [loginTextField, invalidLoginLabel ,passwordTextField, invalidPasswordLabel])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.setCustomSpacing(20, after: invalidLoginLabel)
        stackView.distribution = .fillProportionally
        return stackView
    }
    
    func createErrorLabel(text: String) -> UILabel {
        let errorLabel = UILabel()
        errorLabel.text = text
        errorLabel.textColor = .systemRed
        errorLabel.font = .systemFont(ofSize: 14)
        errorLabel.textAlignment = .left
        errorLabel.numberOfLines = 3
        return errorLabel
    }
    
    func setUpUI() {
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            stackView.heightAnchor.constraint(equalToConstant: 220),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
    }
    
}
