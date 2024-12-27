
import UIKit

class CurrentDayCell: UICollectionViewCell {
    
    public func configure(with day: Day) {
        let button = createButton(title: String(day.number))
        backgroundColor = .white
        button.addTarget(self, action: #selector(buttonTapped), for: .touchDown)
    }
    
    @objc private func buttonTapped(sender: UIButton) {
        sender.backgroundColor = .black.withAlphaComponent(0.05)
    }
}


extension CurrentDayCell {
    func createButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.backgroundColor = .black.withAlphaComponent(0.01)
        button.setTitleColor(.black, for: .normal)
        button.tintColor = .purple
        
        let view = UIView()
        view.backgroundColor = .systemPurple
        view.layer.cornerRadius = 25
        
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 30)
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
            view.widthAnchor.constraint(equalToConstant: 50),
            view.heightAnchor.constraint(equalToConstant: 50)
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
