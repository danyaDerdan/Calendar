import UIKit

final class EventViewController: UIViewController {
    
    var viewModel: EventViewModelProtocol!
    var viewData: EventSettings = .invalid {
        didSet {
            updateView()
        }
    }
    
    lazy var nameTextField = createTextField(placeholder: "Name")
    lazy var descriptionTextField = createTextField(placeholder: "Description")
    lazy var saveButton = createSaveButton()
    lazy var textFieldsView = createTextFieldsView()
    lazy var startDatePicker = createStartDatePicker()
    lazy var endDatePicker = createEndDatePicker()
    lazy var dateView = createDateView()
    let notificationSwitch = UISwitch()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        setUpUI()
        updateView()
        nameTextField.delegate = self
        descriptionTextField.delegate = self
        startDatePicker.addTarget(self, action: #selector(startDatePickerValueChanged), for: .valueChanged)
        if let event = viewModel.event {
            nameTextField.text = event.name
            startDatePicker.date = event.start
            endDatePicker.date = event.end
            notificationSwitch.isOn = event.notification
        }
    }
    
    func updateView() {
        viewModel.updateViewData = { [weak self] viewData in
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
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        
        let line = UIView()
        view.addSubview(line)
        line.backgroundColor = .systemGray6
        line.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            line.heightAnchor.constraint(equalToConstant: 1),
            line.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            line.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            line.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])

        
        return view
    }
    
    func setUpUI() {
        view.addSubview(textFieldsView)
        textFieldsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textFieldsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            textFieldsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textFieldsView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            textFieldsView.heightAnchor.constraint(equalToConstant: 100)
            ])
        
        view.addSubview(dateView)
        dateView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateView.topAnchor.constraint(equalTo: textFieldsView.bottomAnchor, constant: 50),
            dateView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dateView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            dateView.heightAnchor.constraint(equalToConstant: 100)
            ])
        
        addNavigationStackView()
        addNotificationView()
    }
    
    func createSaveButton() -> UIButton {
        let saveButton = UIButton(type: .system)
        saveButton.setTitle("Save", for: .normal)
        saveButton.tintColor = .systemGray
        saveButton.isEnabled = false
        saveButton.addTarget(self, action: #selector(save), for: .touchUpInside)
        return saveButton
    }
    
    func addNavigationStackView() {
        let label = UILabel()
        label.text = "Event"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        
        let exitButton = UIButton(type: .system)
        exitButton.setImage(UIImage(systemName: "chevron.up"), for: .normal)
        exitButton.tintColor = .systemPurple
        exitButton.addTarget(self, action: #selector(exit), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [exitButton, label, saveButton])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        ])
    }
    
    func addNotificationView() {
        let view = UIView()
        self.view.addSubview(view)
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        let label = createLabel(word: "Notification")
        
        let notificationsStackView = UIStackView(arrangedSubviews: [label, notificationSwitch])
        notificationsStackView.axis = .horizontal
        notificationsStackView.distribution = .fill
        
        view.addSubview(notificationsStackView)
        notificationsStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            notificationsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            notificationsStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            notificationsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
            ])
        
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        view.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),
        view.heightAnchor.constraint(equalToConstant: 50),
        view.topAnchor.constraint(equalTo: dateView.bottomAnchor, constant: 50),
        view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        
    }
    
    func createStartDatePicker() -> UIDatePicker {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.minuteInterval = 5
        datePicker.minimumDate = Calendar.current.date(byAdding: .minute, value: -5, to: Date())
        datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: 9, to: Date())
        datePicker.timeZone = Calendar.current.timeZone
        view.addSubview(datePicker)
        
        return datePicker
        
    }
    
    func createEndDatePicker() -> UIDatePicker {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.minuteInterval = 5
        datePicker.minimumDate = Calendar.current.date(byAdding: .minute, value: 5, to: startDatePicker.date)
        datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: 9, to: Date())
        datePicker.timeZone = Calendar.current.timeZone
        datePicker.setDate(Calendar.current.date(byAdding: .hour, value: 1, to: startDatePicker.date)!, animated: true)
        view.addSubview(datePicker)
        
        return datePicker
    }
    
    func createDateView() -> UIView{
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        
        let startStack = UIStackView(arrangedSubviews: [createLabel(word: "Начало"), startDatePicker])
        let endStack = UIStackView(arrangedSubviews: [createLabel(word: "Конец"), endDatePicker])
        
        startStack.axis = .horizontal
        endStack.axis = .horizontal
        
        startStack.distribution = .fill
        endStack.distribution = .fill

        let stack = UIStackView(arrangedSubviews: [startStack, endStack])
        stack.axis = .vertical
        stack.spacing = 6
        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            stack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            ])
        
        let line = UIView()
        view.addSubview(line)
        line.backgroundColor = .systemGray6
        line.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            line.heightAnchor.constraint(equalToConstant: 1),
            line.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            line.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            line.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        
  
        return view
    }
    
    func createLabel(word: String) -> UILabel {
        let label = UILabel()
        label.text = word
        label.font = UIFont.systemFont(ofSize: 20)
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            self.viewModel.validateData(name: textField.text ?? "" + string)
        }
        return true
    }
    
    @objc func startDatePickerValueChanged() {
        if endDatePicker.date < startDatePicker.date {
            endDatePicker.date = startDatePicker.date.addingTimeInterval(60*60)
        }
        endDatePicker.minimumDate = startDatePicker.date.addingTimeInterval(60*5)
        endDatePicker.date = startDatePicker.date.addingTimeInterval(60*60)
    }
    
    @objc func save() {
        if let event = viewModel.event {
            viewModel.coreDataManager.deleteEvent(event: event)
        }
        let newEvent = EventSettings.Event(name: nameTextField.text ?? "",
                                           description: descriptionTextField.text ?? "",
                                           start: startDatePicker.date,
                                           end: endDatePicker.date,
                                           notification: notificationSwitch.isOn)
        viewModel.coreDataManager.saveEvent(newEvent)
        viewModel.reloadViews()
        let notificationManager = NotificationManager()
        notificationManager.addNotification(event: newEvent)
        exit()
    }
}
