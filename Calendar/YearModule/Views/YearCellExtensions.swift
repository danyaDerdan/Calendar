import UIKit

private struct Constants {
    static let dayCellIdentifier = "DayCell"
    static let emptyCellIdentifier = "EmptyCell"
    static let currentDayCellIdentifier = "CurrentDayCell"
    static let headerIdentifier = "Header"
    static let yearLabelFont: UIFont = .boldSystemFont(ofSize: 30)
    static let weekdayLabelFont: UIFont = .systemFont(ofSize: 12)
    static let countOfYears = 12
    static let countOfWeekdays: CGFloat = 7
    static let widthInset: CGFloat = 2
    static let cellHeight: CGFloat = 80
    static let minLineSpacing: CGFloat = 5
    static let sectionWidth: CGFloat = 200
}

extension YearCell {
    
    func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(DayCell.self, forCellWithReuseIdentifier: Constants.dayCellIdentifier)
        collectionView.register(EmptyCell.self, forCellWithReuseIdentifier: Constants.emptyCellIdentifier)
        collectionView.register(CurrentDayCell.self, forCellWithReuseIdentifier: Constants.currentDayCellIdentifier)
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constants.headerIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.scrollsToTop = true
        addSubview(collectionView)
        
        return collectionView
    }
    
    func createYearLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .black
        label.font = Constants.yearLabelFont
        label.textAlignment = .center
        label.text = String(year ?? 0)
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func createLabels() -> [UILabel] {
        var arr = [UILabel]()
        for i in 0..<7 {
            let label = UILabel()
            label.textColor = .black
            label.font = Constants.weekdayLabelFont
            label.textAlignment = .center
            label.text = viewModel?.dateManager?.getDayOfWeek(day: i)
            arr.append(label)
        }
        return arr
    }
    
    func createWeekStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: dayOfWeekLabels)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
}

extension YearCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Constants.countOfYears
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (viewModel?.dateManager?.getDaysInMonth(year: year ?? 0, month: section) ?? 0) + (cellsIndexStart?[section] ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIndexStart = cellsIndexStart?[indexPath.section] ?? 0
        if indexPath.row < cellIndexStart {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.emptyCellIdentifier, for: indexPath) as? EmptyCell {
                cell.setUp()
                return cell
            }
        }
        else {
            let daysCount = days?[indexPath.section].count ?? 0
            let dayIndex = indexPath.row-cellIndexStart < daysCount ? indexPath.row-cellIndexStart : daysCount-1
            if viewModel?.dateManager?.getStringOfDate(Date()) == days?[indexPath.section][dayIndex].date {
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.currentDayCellIdentifier, for: indexPath) as? CurrentDayCell {
                    cell.configure(with: days?[indexPath.section][dayIndex] ?? Day())
                    return cell
                }
            }
            else {
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.dayCellIdentifier, for: indexPath) as? DayCell, let viewModel {
                    cell.configure(with: days?[indexPath.section][dayIndex] ?? Day(), viewModel: viewModel)
                    return cell
                }
            }
        }
        return UICollectionViewCell()
    }
}

extension YearCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / Constants.countOfWeekdays - Constants.widthInset, height: Constants.cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.minLineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.widthInset
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {return UICollectionReusableView()}
        let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constants.headerIdentifier, for: indexPath) as? SectionHeader
        sectionHeader?.label.text = viewModel?.dateManager?.getMonthName(month: indexPath.section)
        return sectionHeader ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: Constants.sectionWidth, height: Constants.cellHeight)
    }
}
