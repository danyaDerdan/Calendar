import UIKit

class DayCell: UICollectionViewCell {
    
    private var month: String?
    lazy var button = createButton()
    
    
    public func configure(with day: Day) {
        button.setTitle(String(day.number), for: .normal)
        month = day.month
        setup()
    }
    
    private func setup() {
        backgroundColor = .white
        button.addTarget(self, action: #selector(buttonTapped), for: .touchDown)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        button.setTitle(nil, for: .normal)
    }
    
    @objc private func buttonTapped(sender: UIButton) {
        sender.backgroundColor = .black.withAlphaComponent(0.05)
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
}
