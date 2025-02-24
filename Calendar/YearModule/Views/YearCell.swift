import UIKit

final class YearCell: UICollectionViewCell {
    
    private struct Constants {
        static let collectionTopInset: CGFloat = 80
        static let verticalInset: CGFloat = 10
        static let leadingInset: CGFloat = 20
        static let offsetMultiplier = 465
    }
    
    var viewModel: YearViewModelProtocol?
    
    var firstDayOfYear: Int?
    var year: Int?
    
    var days: [[Day]]?
    var cellsIndexStart : [Int]?
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    var yearLabel = UILabel()
    lazy var dayOfWeekLabels = createLabels()
    lazy var weekStackView = createWeekStackView()
    
    public func configure(viewModel: YearViewModelProtocol, year: Int, firstDayOfYear: Int) {
        self.viewModel = viewModel
        self.year = year
        self.firstDayOfYear = firstDayOfYear
        setUp()
        
    }
    
    private func setUp() {
        backgroundColor = .systemGray6
        guard let viewModel, let year else { return }
        days = viewModel.getDays(of: year)
        cellsIndexStart = viewModel.dateManager?.getCellsStartIndex(year: year)
        yearLabel = createYearLabel()
        collectionView = createCollectionView()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
       
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.collectionTopInset),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            weekStackView.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -Constants.verticalInset),
            weekStackView.widthAnchor.constraint(equalTo: collectionView.widthAnchor),
            
            yearLabel.bottomAnchor.constraint(equalTo: weekStackView.topAnchor, constant: -Constants.verticalInset),
            yearLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leadingInset)
        ])
        
        guard let date = viewModel.dateManager?.getStringOfDate(Date()).split(separator: ".") else { return }
        if date[2] == String(year) {
            collectionView.setContentOffset(CGPoint(x: 0, y: Constants.offsetMultiplier*(Int(date[1]) ?? 1)-1), animated: true)
        }
        
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
//        collectionView = nil
        yearLabel.text = nil
    }
}


