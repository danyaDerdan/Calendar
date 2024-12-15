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
        setUp()
    }
    
    func setUp() {
        backgroundColor = .systemGray6
        addSubview(weekStackView)
        
        
    }
    
}
