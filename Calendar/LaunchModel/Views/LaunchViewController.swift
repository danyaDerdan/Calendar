import UIKit

class LaunchViewController: UIViewController {

    var viewModel: LaunchViewModel!
    
    lazy var titleLabel = createLabel()
    lazy var loginButton = createButton(text: "Login", backgroundColor: .systemPurple, textColor: .white)
    lazy var registerButton = createButton(text: "Register", backgroundColor: .white, textColor: .systemPurple)
    lazy var stackView = createStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpUI()

    }
}

private extension LaunchViewController {
    func setUpUI() {
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 100),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -100)
            ])
            
    }
    
    func createLabel() -> UILabel {
        let label = UILabel()
        label.text = "Sigmalendar"
        label.font = .boldSystemFont(ofSize: .init(30))
        return label
    }
    
    func createButton(text: String, backgroundColor: UIColor, textColor: UIColor) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(text, for: .normal)
        button.layer.cornerRadius = 30
        button.setTitleColor(textColor, for: .normal)
        button.backgroundColor = backgroundColor
        return button
    }
    
    func createStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, loginButton, registerButton])
        stackView.axis = .vertical
        stackView.spacing = 50
        stackView.setCustomSpacing(200, after: titleLabel)
        stackView.distribution = .fillEqually
        return stackView
    }
}
