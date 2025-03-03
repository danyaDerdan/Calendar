import UIKit

private struct Constants {
    static let sectionViewHeight: CGFloat = 50
    static let cornerRadius: CGFloat = 16
    static let widthMultiplier: CGFloat = 0.8
}

final class SectionView: UIView {
    
    var view: UIView
    var textField: UITextField?
    var datePicker: UIDatePicker?
    var picker: UIPickerView?
    var segmentedControl: UISegmentedControl?
    
    convenience init(view: UIView, textField: UITextField? = nil, datePicker: UIDatePicker? = nil, picker: UIPickerView? = nil, segmentedControl: UISegmentedControl? = nil) {
        self.init(frame: .zero)
        self.view = view
        self.textField = textField
        self.datePicker = datePicker
        self.picker = picker
        self.segmentedControl = segmentedControl
    }
    
    override init(frame: CGRect) {
        self.view = UIView()
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        backgroundColor = .white
        layer.cornerRadius = Constants.cornerRadius
        translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: view.centerXAnchor),
            heightAnchor.constraint(equalToConstant: Constants.sectionViewHeight),
            widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: Constants.widthMultiplier)
            ])
    }
}
