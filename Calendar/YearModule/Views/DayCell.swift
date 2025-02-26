import UIKit

private struct Constants {
    static let backgroundColor: UIColor = .black.withAlphaComponent(0.01)
    static let weekEndColor: UIColor = .black.withAlphaComponent(0.5)
    static let titleFont: UIFont = .boldSystemFont(ofSize: 30)
    static let circleHeight: CGFloat = 10
    static let bottomInset: CGFloat = 5
    
}

class DayCell: UICollectionViewCell {
    
    
    var viewModel: YearViewModelProtocol?
    var button: UIButton?
    var day: Day?
    
    public func configure(with day: Day, viewModel: YearViewModelProtocol) {
        button = createButton()
        button?.setTitle(String(day.number), for: .normal)
        self.viewModel = viewModel
        self.day = day
        setup(day)
    }
    
    private func setup(_ day: Day) {
        backgroundColor = .white
        button?.addTarget(self, action: #selector(buttonTapped), for: .touchDown)
        if viewModel?.dateManager?.isDayInWeekend(day) ?? false {
            button?.setTitleColor(Constants.weekEndColor, for: .normal)
        }
        if day.isEvented { addCircle(on: button ?? UIButton()) }
        
    }
    
    @objc private func buttonTapped() {
        viewModel?.dayCellTapped(day: day)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        button?.setTitle(nil, for: .normal)
        button?.backgroundColor = .white
        day = nil
    }
}


extension DayCell {
    func createButton() -> UIButton {
        let button = UIButton(type: .system)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = Constants.backgroundColor
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = Constants.titleFont
        button.tintColor = .black
        
        addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        button.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        button.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        
        return button
    }
    
    func addCircle(on view: UIView) {
        let circle = UIView()
        circle.layer.cornerRadius = Constants.circleHeight/2
        circle.backgroundColor = .black
        view.addSubview(circle)
        circle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            circle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            circle.heightAnchor.constraint(equalToConstant: Constants.circleHeight),
            circle.widthAnchor.constraint(equalToConstant: Constants.circleHeight),
            circle.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.bottomInset)
        ])
        
        
    }
}
