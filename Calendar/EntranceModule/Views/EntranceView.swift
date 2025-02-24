import UIKit

private struct Constants {
    static let loginPlaceholder: String = "Login"
    static let passwordPlaceholder: String = "Password"
    static let loginErrorText: String = "Логин должен содержать от 6 до 20 символов"
    static let passwordErrorText: String = "Пароль должен содержать от 6 до 20 символов, хотя бы одну латинскую букву и хотя бы один специальный симовл"
    static let errorColor: UIColor = .systemRed
    static let successColor: CGColor = UIColor.systemGreen.cgColor
    static let defaultColor: CGColor = UIColor.systemGray6.cgColor
    static let errorLabelSuccesAlpha: CGFloat = 0
    static let errorLabelFailureAlpha: CGFloat = 1
    static let textFieldCornerRadius: CGFloat = 10
    static let textFieldBorderWidth: CGFloat = 2
    static let stackSpacing: CGFloat = 5
    static let stackCustomSpacing: CGFloat = 20
    static let errorLabelFont: UIFont = .systemFont(ofSize: 14)
    static let errorLabelLinesCount = 3
    static let stackWidthMultiplier: CGFloat = 0.8
    static let stackHeight: CGFloat = 220
}

final class EntranceView: UIView {
    
    var viewData: UserData = .initial {
        didSet {
            setNeedsLayout()
        }
    }
    
    lazy var loginTextField = createTextField(placeholder: Constants.loginPlaceholder)
    lazy var passwordTextField = createTextField(placeholder: Constants.passwordPlaceholder)
    lazy var invalidLoginLabel = createErrorLabel(text: Constants.loginErrorText)
    lazy var invalidPasswordLabel = createErrorLabel(text: Constants.passwordErrorText)
    lazy var stackView = createStackView()
    
    override func layoutSubviews() {
        switch viewData {
        case .initial, .loading:
            loginTextField.layer.borderColor = Constants.defaultColor
            passwordTextField.layer.borderColor = Constants.defaultColor
            invalidLoginLabel.textColor = Constants.errorColor.withAlphaComponent(Constants.errorLabelSuccesAlpha)
            invalidPasswordLabel.textColor = Constants.errorColor.withAlphaComponent(Constants.errorLabelSuccesAlpha)
        case .valid:
            loginTextField.layer.borderColor = Constants.successColor
            passwordTextField.layer.borderColor = Constants.successColor
            invalidLoginLabel.textColor = Constants.errorColor.withAlphaComponent(Constants.errorLabelSuccesAlpha)
            invalidPasswordLabel.textColor = Constants.errorColor.withAlphaComponent(Constants.errorLabelSuccesAlpha)
            
        case .invalid:
            loginTextField.layer.borderColor = Constants.errorColor.cgColor
            passwordTextField.layer.borderColor = Constants.errorColor.cgColor
            invalidLoginLabel.textColor = Constants.errorColor
            invalidPasswordLabel.textColor = Constants.errorColor
        case .loginValid:
            loginTextField.layer.borderColor = Constants.successColor
            passwordTextField.layer.borderColor = Constants.successColor
            invalidLoginLabel.textColor = Constants.errorColor.withAlphaComponent(Constants.errorLabelSuccesAlpha)
            invalidPasswordLabel.textColor = Constants.errorColor.withAlphaComponent(Constants.errorLabelFailureAlpha)
        case .passwordValid:
            loginTextField.layer.borderColor = Constants.errorColor.cgColor
            passwordTextField.layer.borderColor = Constants.successColor
            invalidLoginLabel.textColor = Constants.errorColor.withAlphaComponent(Constants.errorLabelFailureAlpha)
            invalidPasswordLabel.textColor = Constants.errorColor.withAlphaComponent(Constants.errorLabelSuccesAlpha)
        }
    }
}




extension EntranceView {
    
    func createTextField(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = Constants.textFieldCornerRadius
        textField.layer.borderWidth = Constants.textFieldBorderWidth
        textField.layer.borderColor = Constants.defaultColor
        return textField
    }
    
    func createStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [loginTextField, invalidLoginLabel ,passwordTextField, invalidPasswordLabel])
        stackView.axis = .vertical
        stackView.spacing = Constants.stackSpacing
        stackView.setCustomSpacing(Constants.stackCustomSpacing, after: invalidLoginLabel)
        stackView.distribution = .fillProportionally
        return stackView
    }
    
    func createErrorLabel(text: String) -> UILabel {
        let errorLabel = UILabel()
        errorLabel.text = text
        errorLabel.textColor = .systemRed
        errorLabel.font = Constants.errorLabelFont
        errorLabel.textAlignment = .left
        errorLabel.numberOfLines = Constants.errorLabelLinesCount
        return errorLabel
    }
    
    func setUpUI() {
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.stackWidthMultiplier),
            stackView.heightAnchor.constraint(equalToConstant: Constants.stackHeight),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
    }

    
}
