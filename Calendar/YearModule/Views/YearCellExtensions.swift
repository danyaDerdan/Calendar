import UIKit

extension YearCell {
    
    func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(DayCell.self, forCellWithReuseIdentifier: "DayCell")
        collectionView.register(EmptyCell.self, forCellWithReuseIdentifier: "EmptyCell")
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 80),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor) ])
        
        return collectionView
    }
    
    func createYearLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .black
        label.text = String(year)
        label.font = .boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        yearLabel.bottomAnchor.constraint(equalTo: weekStackView.topAnchor, constant: -10).isActive = true
        yearLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        
        return label
    }
    
    func createLabels() -> [UILabel] {
        var arr = [UILabel]()
        for i in 0..<12 {
            let label = UILabel()
            label.textColor = .black
            label.font = .systemFont(ofSize: 12)
            label.textAlignment = .center
            label.text = viewModel.dataManager.getDayOfWeek(day: i)
            arr.append(label)
        }
        return arr
    }
    
    func createWeekStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: dayOfWeekLabels)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -10).isActive = true
        stackView.widthAnchor.constraint(equalTo: collectionView.widthAnchor).isActive = true
        
        return stackView
    }
}

extension YearCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dataManager.getDaysInMonth(year: year, month: section) + cellsIndexStart[section]
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row < cellsIndexStart[indexPath.section] {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmptyCell", for: indexPath) as? EmptyCell else { return UICollectionViewCell() }
            cell.setUp()
            return cell
        }
        else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayCell", for: indexPath) as? DayCell else { return UICollectionViewCell() }
            cell.configure(with: days[indexPath.section][indexPath.row-cellsIndexStart[indexPath.section]])
            return cell
        }
    }
}

extension YearCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 7 - 2, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {return UICollectionReusableView()}
        let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as! SectionHeader
        sectionHeader.label.text = viewModel.dataManager.getMonthName(month: indexPath.section)
        return sectionHeader
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 200, height: 80)
    }
}
