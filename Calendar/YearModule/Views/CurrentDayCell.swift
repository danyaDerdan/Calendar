
import UIKit

private struct Constants {
    static let backgroundColorTapped: UIColor = .black.withAlphaComponent(0.05)
    static let backgroundColor: UIColor = .black.withAlphaComponent(0.01)
    static let cornerRadius: CGFloat = 25
    static let titleFont: UIFont = .boldSystemFont(ofSize: 30)
    static let width: CGFloat = 50
}

class CurrentDayCell: UICollectionViewCell {
    
    public func configure(with day: Day) {
        let button = createButton(title: String(day.number))
        backgroundColor = .white
        button.addTarget(self, action: #selector(buttonTapped), for: .touchDown)
    }
    
    @objc private func buttonTapped(sender: UIButton) {
        sender.backgroundColor = Constants.backgroundColorTapped
    }
}


extension CurrentDayCell {
    func createButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.backgroundColor = Constants.backgroundColor
        button.setTitleColor(.black, for: .normal)
        button.tintColor = .purple
        
        let view = UIView()
        view.backgroundColor = .systemPurple
        view.layer.cornerRadius = Constants.cornerRadius
        
        let label = UILabel()
        label.font = Constants.titleFont
        label.textColor = .white
        label.text = title
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        button.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            view.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            view.widthAnchor.constraint(equalToConstant: Constants.width),
            view.heightAnchor.constraint(equalToConstant: Constants.width)
            ])
        
        
        
        addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        button.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        button.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        
        return button
    }
}
