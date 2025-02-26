import UIKit

private struct Constants {
    static let namePlaceholder = "Name"
    static let descriptionPlaceholder = "Description"
    static let saveButtonTitle = "Save"
    static let lineHeight: CGFloat = 1
    static let stackSpacing: CGFloat = 10
    static let cornerRadius: CGFloat = 16
    static let stackLeadigInset: CGFloat = 20
    static let stackVerticalInset: CGFloat = 10
    static let textFieldVerticalInset: CGFloat = 100
    static let textFieldWidthMultiplier: CGFloat = 0.9
    static let textFieldHeight: CGFloat = 100
    static let dateViewVerticalInset: CGFloat = 50
    static let eventTitle = "Event"
    static let eventLabelFont : UIFont = .systemFont(ofSize: 20, weight: .bold)
    static let exitImageName = "chevron.up"
    static let navigationStackInset: CGFloat = 40
    static let navigationStackWidthMultiplier: CGFloat = 0.8
    static let notificationTitle = "Notification"
    static let notificationCornerRadius: CGFloat = 16
    static let notificationViewInset: CGFloat = 20
    static let notificationViewHeight: CGFloat = 50
    static let notificationViewWidthMultiplier: CGFloat = 0.9
    static let datePickerMinuteInterval = 5
    static let countOfYears = 9
    static let dateViewCornerRadius: CGFloat = 16
    static let dateViewStackSpacing: CGFloat = 6
    static let startWord = "Начало"
    static let endWord = "Конец"
    static let countOfMinutes: Double = 60
}

final class EventViewController: UIViewController {
    
    var viewModel: EventViewModelProtocol?
    var viewData: EventSettings = .invalid {
        didSet {
            updateView()
        }
    }
    
    lazy var nameTextField = createTextField(placeholder: Constants.namePlaceholder)
    lazy var descriptionTextField = createTextField(placeholder: Constants.descriptionPlaceholder)
    lazy var saveButton = createSaveButton()
    lazy var textFieldsView = createTextFieldsView()
    lazy var startDatePicker = createStartDatePicker()
    lazy var endDatePicker = createEndDatePicker()
    lazy var dateView = createDateView()
    let notificationSwitch = UISwitch()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        setupUI()
        updateView()
        nameTextField.delegate = self
        descriptionTextField.delegate = self
        startDatePicker.addTarget(self, action: #selector(startDatePickerValueChanged), for: .valueChanged)
        if let event = viewModel?.event {
            nameTextField.text = event.name
            startDatePicker.setDate(event.start, animated: true)
            endDatePicker.setDate(event.end, animated: true)
            notificationSwitch.isOn = event.notification
        }
    }
    
    func updateView() {
        viewModel?.updateViewData = { [weak self] viewData in
            self?.viewData = viewData
            switch viewData {
            case .invalid:
                self?.saveButton.tintColor = .systemGray
                self?.saveButton.isEnabled = false
            case .valid:
                self?.saveButton.tintColor = .systemPurple
                self?.saveButton.isEnabled = true
            }
        }
    }
    
}


extension EventViewController: UITextFieldDelegate{
    
    func createTextField(placeholder: String) -> UITextField {
        let nameTextField = UITextField()
        nameTextField.placeholder = placeholder
        return nameTextField
    }
    
    func createTextFieldsView() -> UIView {
        let stackView = UIStackView(arrangedSubviews: [nameTextField, descriptionTextField])
        stackView.axis = .vertical
        stackView.spacing = Constants.stackSpacing
        stackView.distribution = .fillEqually
        
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = Constants.cornerRadius
        
        let line = UIView()
        view.addSubview(line)
        line.backgroundColor = .systemGray6
        line.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            line.heightAnchor.constraint(equalToConstant: Constants.lineHeight),
            line.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.stackLeadigInset),
            line.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            line.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.stackVerticalInset),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.stackVerticalInset),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.stackLeadigInset),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        return view
    }
    
    func setupUI() {
        view.addSubview(textFieldsView)
        textFieldsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textFieldsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.textFieldVerticalInset),
            textFieldsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textFieldsView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: Constants.textFieldWidthMultiplier),
            textFieldsView.heightAnchor.constraint(equalToConstant: Constants.textFieldHeight)
            ])
        
        view.addSubview(dateView)
        dateView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateView.topAnchor.constraint(equalTo: textFieldsView.bottomAnchor, constant: Constants.dateViewVerticalInset),
            dateView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dateView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: Constants.textFieldWidthMultiplier),
            dateView.heightAnchor.constraint(equalToConstant: Constants.textFieldHeight)
            ])
        
        addNavigationStackView()
        addNotificationView()
    }
    
    func createSaveButton() -> UIButton {
        let saveButton = UIButton(type: .system)
        saveButton.setTitle(Constants.saveButtonTitle, for: .normal)
        saveButton.tintColor = .systemGray
        saveButton.isEnabled = false
        saveButton.addTarget(self, action: #selector(save), for: .touchUpInside)
        return saveButton
    }
    
    func addNavigationStackView() {
        let label = UILabel()
        label.text = Constants.eventTitle
        label.font = Constants.eventLabelFont
        label.textColor = .black
        label.textAlignment = .center
        
        let exitButton = UIButton(type: .system)
        exitButton.setImage(UIImage(systemName: Constants.exitImageName), for: .normal)
        exitButton.tintColor = .systemPurple
        exitButton.addTarget(self, action: #selector(exit), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [exitButton, label, saveButton])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.navigationStackInset),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: Constants.navigationStackWidthMultiplier)
        ])
    }
    
    func addNotificationView() {
        let view = UIView()
        self.view.addSubview(view)
        view.backgroundColor = .white
        view.layer.cornerRadius = Constants.notificationCornerRadius
        let label = createLabel(word: Constants.notificationTitle)
        
        let notificationsStackView = UIStackView(arrangedSubviews: [label, notificationSwitch])
        notificationsStackView.axis = .horizontal
        notificationsStackView.distribution = .fill
        
        view.addSubview(notificationsStackView)
        notificationsStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            notificationsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            notificationsStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            notificationsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.notificationViewInset),
            notificationsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.notificationViewInset)
            ])
        
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: Constants.notificationViewWidthMultiplier),
            view.heightAnchor.constraint(equalToConstant: Constants.notificationViewHeight),
            view.topAnchor.constraint(equalTo: dateView.bottomAnchor, constant: Constants.notificationViewInset),
        view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        
    }
    
    func createStartDatePicker() -> UIDatePicker {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.minuteInterval = Constants.datePickerMinuteInterval
        datePicker.minimumDate = viewModel?.event?.start ?? Date()
        datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: Constants.countOfYears, to: Date())
        datePicker.timeZone = Calendar.current.timeZone
        view.addSubview(datePicker)
        
        return datePicker
        
    }
    
    func createEndDatePicker() -> UIDatePicker {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.minuteInterval = Constants.datePickerMinuteInterval
        datePicker.minimumDate = viewModel?.event?.end ?? Date()
        datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: Constants.countOfYears, to: Date())
        datePicker.timeZone = Calendar.current.timeZone
        datePicker.setDate(Calendar.current.date(byAdding: .hour, value: 1, to: startDatePicker.date) ?? Date(), animated: true)
        view.addSubview(datePicker)
        
        return datePicker
    }
    
    func createDateView() -> UIView{
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = Constants.dateViewCornerRadius
        
        let startStack = UIStackView(arrangedSubviews: [createLabel(word: Constants.startWord), startDatePicker])
        let endStack = UIStackView(arrangedSubviews: [createLabel(word: Constants.endWord), endDatePicker])
        
        startStack.axis = .horizontal
        endStack.axis = .horizontal
        
        startStack.distribution = .fill
        endStack.distribution = .fill

        let stack = UIStackView(arrangedSubviews: [startStack, endStack])
        stack.axis = .vertical
        stack.spacing = Constants.dateViewStackSpacing
        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.stackVerticalInset),
            stack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.stackVerticalInset),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.stackLeadigInset),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.stackLeadigInset)
            ])
        
        let line = UIView()
        view.addSubview(line)
        line.backgroundColor = .systemGray6
        line.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            line.heightAnchor.constraint(equalToConstant: Constants.lineHeight),
            line.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.stackLeadigInset),
            line.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            line.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        
  
        return view
    }
    
    func createLabel(word: String) -> UILabel {
        let label = UILabel()
        label.text = word
        label.font = Constants.eventLabelFont
        label.textColor = .black
        label.textAlignment = .left
        return label
    }
    
    @objc func exit() {
        dismiss(animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) { [weak self] in
            self?.viewModel?.validateData(name: textField.text ?? "" + string)
        }
        return true
    }
    
    @objc func startDatePickerValueChanged() {
        if endDatePicker.date < startDatePicker.date {
            endDatePicker.date = startDatePicker.date.addingTimeInterval(Constants.countOfMinutes*Constants.countOfMinutes)
        }
        endDatePicker.minimumDate = startDatePicker.date.addingTimeInterval(Constants.countOfMinutes*Double(Constants.datePickerMinuteInterval))
        endDatePicker.date = startDatePicker.date.addingTimeInterval(Constants.countOfMinutes*Constants.countOfMinutes)
    }
    
    @objc func save() {
        viewModel?.saveEvent(
            name: nameTextField.text,
            description: descriptionTextField.text,
            start: startDatePicker.date,
            end: endDatePicker.date,
            notification: notificationSwitch.isOn
        )
        exit()
    }
}
