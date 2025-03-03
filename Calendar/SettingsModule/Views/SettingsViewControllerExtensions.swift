import UIKit

private struct Constants {
    static let sectionViewHeight: CGFloat = 50
    static let widthMultiplier: CGFloat = 0.8
    static let cornerRadius: CGFloat = 16
    static let placeholderText: String = "Name"
    static let leadingInset: CGFloat = 20
    static let sectionSpacing: CGFloat = 40
    static let colorNames = ["Red", "Blue", "Yellow", "Green"]
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
}

extension SettingsViewController {
    
    private func createSectionView() -> UIView {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = Constants.cornerRadius
        view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(view)
        NSLayoutConstraint.activate([
            view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            view.heightAnchor.constraint(equalToConstant: Constants.sectionViewHeight),
            view.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: Constants.widthMultiplier)
            ])
        return view
    }
    
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
    
    func createNameView() -> UIView {
        let section = createSectionView()
        section.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constants.sectionSpacing).isActive = true
        let textField = UITextField()
        textField.placeholder = Constants.placeholderText
        textField.translatesAutoresizingMaskIntoConstraints = false
        section.addSubview(textField)
        NSLayoutConstraint.activate([
            textField.centerYAnchor.constraint(equalTo: section.centerYAnchor),
            textField.leadingAnchor.constraint(equalTo: section.leadingAnchor, constant: Constants.leadingInset)
            ])
        return section
    }
    
    func createColorView() -> UIView {
        let section = createSectionView()
        section.topAnchor.constraint(equalTo: birthdayView.bottomAnchor, constant: Constants.sectionSpacing).isActive = true
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
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
        return section
    }
    
    func createBirthdayView() -> UIView {
        let section = createSectionView()
        section.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: Constants.sectionSpacing).isActive = true
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
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
    
    func createSoundView() -> UIView {
        let section = createSectionView()
        section.topAnchor.constraint(equalTo: colorView.bottomAnchor, constant: Constants.sectionSpacing).isActive = true
        let segmentedControl = UISegmentedControl()
        segmentedControl.insertSegment(withTitle: Constants.defaultSoundName, at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: Constants.criticalSoundName, at: 1, animated: true)
        segmentedControl.selectedSegmentIndex = 0
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
    
    private func createColorLabel(stringColor: String) -> UIView {
        var color = UIColor.red.withAlphaComponent(0.5)
        switch stringColor {
        case "Blue": color = .blue.withAlphaComponent(0.5)
        case "Green": color = .green.withAlphaComponent(0.5)
        case "Yellow": color = .yellow.withAlphaComponent(0.5)
        default: break
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
