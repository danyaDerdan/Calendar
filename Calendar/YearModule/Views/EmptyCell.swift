import UIKit

class EmptyCell: UICollectionViewCell {
    public func setUp() {
        backgroundColor = .black.withAlphaComponent(0.01)
    }
}
