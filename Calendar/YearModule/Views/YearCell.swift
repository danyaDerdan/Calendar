import UIKit

final class YearCell: UICollectionViewCell {
    
    var viewModel: YearViewModelProtocol!
    
    var firstDayOfYear: Int!
    var year: Int!
    
    lazy var days = viewModel.getDays(of: year)
    lazy var cellsIndexStart = viewModel.dataManager.getCellsStartIndex(year: year)
    
    lazy var collectionView = createCollectionView()
    lazy var yearLabel = createYearLabel()
    lazy var dayOfWeekLabels = createLabels()
    lazy var weekStackView = createWeekStackView()
    
    func configure(viewModel: YearViewModelProtocol, year: Int, firstDayOfYear: Int) {
        self.viewModel = viewModel
        self.year = year
        self.firstDayOfYear = firstDayOfYear
        yearLabel.text = String(year)
        collectionView.delegate = self
        collectionView.dataSource = self
        setUp()
    }
    
    func setUp() {
        backgroundColor = .systemGray6
        NSLayoutConstraint.activate([
        collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 80),
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
        
        weekStackView.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -10),
        weekStackView.widthAnchor.constraint(equalTo: collectionView.widthAnchor),
        
        yearLabel.bottomAnchor.constraint(equalTo: weekStackView.topAnchor, constant: -10),
        yearLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
        ])
        
    }
    
}


