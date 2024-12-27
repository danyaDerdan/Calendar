import UIKit
import Foundation

class DayCell: UICollectionViewCell {
    
    
    var viewModel: YearViewModelProtocol!
    var button: UIButton!
    var day: Day!
    
    public func configure(with day: Day, viewModel: YearViewModelProtocol) {
        button = createButton()
        button.setTitle(String(day.number), for: .normal)
        self.viewModel = viewModel
        self.day = day
        setup(day)
    }
    
    private func setup(_ day: Day) {
        DispatchQueue.main.async {
            self.backgroundColor = .white
            let formatter = DateFormatter()
            formatter.dateFormat = "d.M.yyyy"
            self.button.addTarget(self, action: #selector(self.buttonTapped), for: .touchDown)
            guard let date = formatter.date(from: "\(day.number).\(day.month).\(day.year)")?.addingTimeInterval(TimeInterval(60*60*4)) else { return }
            if Calendar.current.isDateInWeekend(date) {
                self.button.setTitleColor(.black.withAlphaComponent(0.5), for: .normal)
            }
            if day.isEvented { self.addCircle(on: self.button) }
        }
        
    }
    
    @objc private func buttonTapped(sender: UIButton) {
        viewModel.router.showDayModule(with: day)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        button.setTitle(nil, for: .normal)
        button.backgroundColor = .white
        day = nil
    }
}


extension DayCell {
    func createButton() -> UIButton {
        let button = UIButton(type: .system)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .black.withAlphaComponent(0.01)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 30)
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
        circle.layer.cornerRadius = 5
        circle.backgroundColor = .black
        view.addSubview(circle)
        circle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            circle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            circle.heightAnchor.constraint(equalToConstant: 10),
            circle.widthAnchor.constraint(equalToConstant: 10),
            circle.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5)
        ])
        
        
    }
}
