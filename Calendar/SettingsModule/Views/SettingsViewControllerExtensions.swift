import UIKit

private struct Constants {
    static let sectionViewHeight: CGFloat = 50
    static let widthMultiplier: CGFloat = 0.8
    static let cornerRadius: CGFloat = 16
    static let placeholderText: String = "Name"
    static let leadingInset: CGFloat = 20
    static let sectionSpacing: CGFloat = 40
    static let colorNames = ["Blue", "Green", "Pink", "Purple"]
    static let columnsInPicker: Int = 1
    static let pickerWidth: CGFloat = 120
    static let circleHeight: CGFloat = 20
    static let imageViewSize: CGFloat = 120
    static let imageTopInset: CGFloat = 80
    static let personImage = "person.circle"
    static let colorText = "Theme color"
    static let cornerRadiusDivider: CGFloat = 2
    static let birhdayLabelText = "Birthday"
    static let defaultSoundName: String = "Default"
    static let criticalSoundName: String = "Critical"
    static let soundLabelText = "Sound"
    static let pickerLabelHeight: CGFloat = 32
    static let labelPickerSpacing: CGFloat = 8
    static let alphaComponent: CGFloat = 0.5
    static let soundsIndexes: [String: Int] = ["Default": 0, "Critical": 1]
}

extension SettingsViewController {
    
    func createImageView() -> UIImageView {
        let imageView = UIImageView(image: UIImage(systemName: Constants.personImage))
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = Constants.imageViewSize / Constants.cornerRadiusDivider
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.imageTopInset),
            imageView.heightAnchor.constraint(equalToConstant: Constants.imageViewSize),
            imageView.widthAnchor.constraint(equalToConstant: Constants.imageViewSize)
            ])
        return imageView
    }
    
    func createNameView() -> SectionView {
        let textField = UITextField()
        let section = SectionView(view: view, textField: textField)
        section.setupUI()
        section.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constants.sectionSpacing).isActive = true
        textField.text = viewModel?.settings.name
        textField.placeholder = Constants.placeholderText
        textField.translatesAutoresizingMaskIntoConstraints = false
        section.addSubview(textField)
        NSLayoutConstraint.activate([
            textField.centerYAnchor.constraint(equalTo: section.centerYAnchor),
            textField.leadingAnchor.constraint(equalTo: section.leadingAnchor, constant: Constants.leadingInset)
            ])
        return section
    }
    
    func createColorView() -> SectionView {
        let picker = UIPickerView()
        let section = SectionView(view: view, picker: picker)
        section.setupUI()
        section.topAnchor.constraint(equalTo: birthdayView.bottomAnchor, constant: Constants.sectionSpacing).isActive = true
        picker.delegate = self
        picker.dataSource = self
        let selectedRow = switch viewModel?.settings.themeColor {
        case .blue: 0
        case .green: 1
        case .pink: 2
        case .purple: 3
        case nil: 0
        }
        picker.selectRow(selectedRow, inComponent: 0, animated: true)
        section.addSubview(picker)
        picker.translatesAutoresizingMaskIntoConstraints = false
        let label = UILabel()
        label.text = Constants.colorText
        section.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            picker.trailingAnchor.constraint(equalTo: section.trailingAnchor, constant: -Constants.leadingInset),
            picker.centerYAnchor.constraint(equalTo: section.centerYAnchor),
            picker.widthAnchor.constraint(equalToConstant: Constants.pickerWidth),
            picker.heightAnchor.constraint(equalTo: section.heightAnchor, multiplier: Constants.cornerRadiusDivider),
            label.centerYAnchor.constraint(equalTo: section.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: section.leadingAnchor, constant: Constants.leadingInset)
            ])
        picker.selectedRow(inComponent: 0)
        return section
    }
    
    func createBirthdayView() -> SectionView {
        let datePicker = UIDatePicker()
        let section = SectionView(view: view, datePicker: datePicker)
        section.setupUI()
        section.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: Constants.sectionSpacing).isActive = true
        datePicker.datePickerMode = .date
        datePicker.date = viewModel?.settings.birthday ?? Date()
        section.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            datePicker.centerYAnchor.constraint(equalTo: section.centerYAnchor),
            datePicker.trailingAnchor.constraint(equalTo: section.trailingAnchor, constant: -Constants.leadingInset)
        ])
        let label = UILabel()
        label.text = Constants.birhdayLabelText
        label.translatesAutoresizingMaskIntoConstraints = false
        section.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: section.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: section.leadingAnchor, constant: Constants.leadingInset)
        ])
        return section
    }
    
    func createSoundView() -> SectionView {
        let segmentedControl = UISegmentedControl()
        let section = SectionView(view: view, segmentedControl: segmentedControl)
        section.setupUI()
        section.topAnchor.constraint(equalTo: colorView.bottomAnchor, constant: Constants.sectionSpacing).isActive = true
        segmentedControl.insertSegment(withTitle: Constants.defaultSoundName, at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: Constants.criticalSoundName, at: 1, animated: true)
        segmentedControl.selectedSegmentIndex = switch viewModel?.settings.notificationSound {
        case .defaultSound: 0
        case .critical: 1
        case nil: 0
        }
        let label = UILabel()
        label.text = Constants.soundLabelText
        label.textAlignment = .left
        let stack = UIStackView(arrangedSubviews: [label, segmentedControl])
        stack.axis = .horizontal
        stack.distribution = .fill
        section.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.centerYAnchor.constraint(equalTo: section.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: section.leadingAnchor, constant: Constants.leadingInset),
            stack.trailingAnchor.constraint(equalTo: section.trailingAnchor, constant: -Constants.leadingInset),
            ])
        return section
    }
    
    func getSelectedColor() -> String {
        return Constants.colorNames[colorView.picker?.selectedRow(inComponent: 0) ?? 0].lowercased()
    }
    
    func getSelectedSound() -> String {
        return soundView.segmentedControl?.selectedSegmentIndex == 0 ? "default" : "critical"
    }
    
    private func createColorLabel(stringColor: String) -> UIView {
        let color: UIColor = switch stringColor {
        case "Green": .green.withAlphaComponent(Constants.alphaComponent)
        case "Pink": .systemPink.withAlphaComponent(Constants.alphaComponent)
        case "Purple": .purple.withAlphaComponent(Constants.alphaComponent)
        default: .blue.withAlphaComponent(Constants.alphaComponent)
        }
        let view = UIView()
        let label = UILabel()
        let circle = UIView()
        circle.backgroundColor = color
        label.text = stringColor
        [label, circle].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        circle.layer.cornerRadius = Constants.pickerLabelHeight / Constants.cornerRadiusDivider
        NSLayoutConstraint.activate([
            circle.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            circle.heightAnchor.constraint(equalTo: view.heightAnchor),
            circle.widthAnchor.constraint(equalTo: view.heightAnchor),
            circle.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.labelPickerSpacing)
        ])
        
        return view
    }
}

extension SettingsViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return Constants.columnsInPicker
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Constants.colorNames.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        return createColorLabel(stringColor: Constants.colorNames[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return Constants.pickerLabelHeight
    }
}
