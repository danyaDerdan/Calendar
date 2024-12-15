import UIKit

class SectionHeader: UICollectionReusableView {
    let label : UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 30)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    let line: UIView = {
        let line = UIView()
        line.backgroundColor = .black.withAlphaComponent(0.5)
        return line
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: leftAnchor, constant: 60).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        addSubview(line)
        line.translatesAutoresizingMaskIntoConstraints = false
        line.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        line.heightAnchor.constraint(equalToConstant: 2).isActive = true
        line.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        line.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
