import UIKit

extension YearCell {
    
    func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(DayCell.self, forCellWithReuseIdentifier: "DayCell")
        collectionView.register(EmptyCell.self, forCellWithReuseIdentifier: "EmptyCell")
        collectionView.register(CurrentDayCell.self, forCellWithReuseIdentifier: "CurrentDayCell")
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.scrollsToTop = true
        addSubview(collectionView)
        
        return collectionView
    }
    
    func createYearLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 30)
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
            label.font = .systemFont(ofSize: 12)
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
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (viewModel?.dateManager?.getDaysInMonth(year: year ?? 0, month: section) ?? 0) + (cellsIndexStart?[section] ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIndexStart = cellsIndexStart?[indexPath.section] ?? 0
        if indexPath.row < cellIndexStart {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmptyCell", for: indexPath) as? EmptyCell {
                cell.setUp()
                return cell
            }
        }
        else {
            let daysCount = days?[indexPath.section].count ?? 0
            let dayIndex = indexPath.row-cellIndexStart < daysCount ? indexPath.row-cellIndexStart : daysCount-1
            if viewModel?.dateManager?.getStringOfDate(Date()) == days?[indexPath.section][dayIndex].date {
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CurrentDayCell", for: indexPath) as? CurrentDayCell {
                    cell.configure(with: days?[indexPath.section][dayIndex] ?? Day())
                    return cell
                }
            }
            else {
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayCell", for: indexPath) as? DayCell, let viewModel {
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
        return CGSize(width: collectionView.frame.width / 7 - 2, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {return UICollectionReusableView()}
        let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as? SectionHeader
        sectionHeader?.label.text = viewModel?.dateManager?.getMonthName(month: indexPath.section)
        return sectionHeader ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 200, height: 80)
    }
}
