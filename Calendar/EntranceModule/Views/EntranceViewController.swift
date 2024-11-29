import UIKit

final class EntranceViewController: UIViewController {
    
    public var viewModel: EntranceViewModelProtocol!
    private var textFieldsView: EntranceView!
    public var buttonTitle: String = "Enter"
    lazy var button = createButton(title: buttonTitle)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpView()
        updateView()
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    func updateView() {
        viewModel.updateViewData = { [weak self] (viewData) in
            self?.textFieldsView.viewData = viewData
        }
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
        button.titleLabel?.font = .boldSystemFont(ofSize: 30)
        button.layer.cornerRadius = 30
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
        button.heightAnchor.constraint(equalToConstant: 80)
        ])
        return button
    }
    
    @objc func buttonTapped() {
        let (login, password) = (textFieldsView.loginTextField.text ?? "", textFieldsView.passwordTextField.text ?? "")
        viewModel.validateData(data: UserData.Data(login: login, password: password))
    }
}

