import UIKit

final class YearCell: UICollectionViewCell {
    
    var viewModel: YearViewModelProtocol?
    
    var firstDayOfYear: Int?
    var year: Int!
    
    var days: [[Day]]!
    var cellsIndexStart : [Int]!
    
    var collectionView: UICollectionView!
    var yearLabel: UILabel!
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
        days = viewModel!.getDays(of: year)
        cellsIndexStart = viewModel!.dataManager.getCellsStartIndex(year: year!)
        yearLabel = createYearLabel()
        collectionView = createCollectionView()
        collectionView.delegate = self
        collectionView.dataSource = self
        print("year \(year)")
       
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        collectionView = nil
//        year = nil
        //print("Prepared \(year)")
        yearLabel.text = nil
    }
}


