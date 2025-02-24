import UIKit

private struct Constants {
    static let labelFont: UIFont = .boldSystemFont(ofSize: 30)
    static let backgroundColor: UIColor = .black.withAlphaComponent(0.5)
    static let leftInset: CGFloat = 60
    static let lineHeight: CGFloat = 2
}

class SectionHeader: UICollectionReusableView {
    let label : UILabel = {
        let label = UILabel()
        label.font = Constants.labelFont
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    let line: UIView = {
        let line = UIView()
        line.backgroundColor = Constants.backgroundColor
        return line
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: leftAnchor, constant: Constants.leftInset).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        addSubview(line)
        line.translatesAutoresizingMaskIntoConstraints = false
        line.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        line.heightAnchor.constraint(equalToConstant: Constants.lineHeight).isActive = true
        line.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        line.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
