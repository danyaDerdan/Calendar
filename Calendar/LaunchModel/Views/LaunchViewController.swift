import UIKit

class LaunchViewController: UIViewController {

    public var viewModel: LaunchViewModel!
    
    lazy var titleLabel = createLabel()
    lazy var loginButton = createButton(text: "Login", backgroundColor: .systemPurple, textColor: .white)
    lazy var registerButton = createButton(text: "Register", backgroundColor: .white, textColor: .systemPurple)
    lazy var stackView = createStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpUI()
        //addTargets()
    }
}

private extension LaunchViewController {
    func setUpUI() {
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 70),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -70)
            ])
    }
    
    func addTargets() {
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
    }
    
    func createLabel() -> UILabel {
        let label = UILabel()
        label.text = "Sigmalendar"
        label.font = .boldSystemFont(ofSize: .init(36))
        label.textAlignment = .center
        return label
    }
    
    func createButton(text: String, backgroundColor: UIColor, textColor: UIColor) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(text, for: .normal)
        button.layer.cornerRadius = 30
        button.setTitleColor(textColor, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: .init(24))
        button.backgroundColor = backgroundColor
        button.layer.borderColor = UIColor.systemPurple.cgColor
        button.layer.borderWidth = 6
        return button
    }
    
    func createStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, loginButton, registerButton])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 50
        stackView.setCustomSpacing(260, after: titleLabel)
        stackView.distribution = .fillEqually
        return stackView
    }
    
    @objc func loginButtonTapped() {
        viewModel.router.showLoginModule()
    }
    
    @objc func registerButtonTapped() {
        viewModel.router.showRegisterModule()
    }
}
