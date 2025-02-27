import UIKit

private struct Constants {
    static let bottomInset: CGFloat = 100
    static let yearCellIdentifier = "YearCell"
    static let plusImageName = "plus.circle.fill"
    static let buttonWidth: CGFloat = 60
    static let buttonInset: CGFloat = 30
    static let yearsCount: Int = 20
    static let firstYear = 2025 //TO DO: More flexible
    static let cellSpacing: CGFloat = 0
}

extension YearViewController {
    func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        view.addSubview(collectionView)
  
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.bottomInset),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor) ])
        collectionView.register(YearCell.self, forCellWithReuseIdentifier: Constants.yearCellIdentifier)
        
        return collectionView
    }
    
    func createPlusButton() -> UIButton {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: Constants.plusImageName), for: .normal)
        button.tintColor = .systemPurple
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: Constants.buttonWidth),
            button.heightAnchor.constraint(equalToConstant: Constants.buttonWidth),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.buttonInset),
            
        ])
        
        return button
    }
}

extension YearViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constants.yearsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.yearCellIdentifier, for: indexPath) as? YearCell, let viewModel else { return UICollectionViewCell() }
        
        cell.configure(viewModel: viewModel, year: indexPath.row+Constants.firstYear, firstDayOfYear: viewModel.dateManager?.getFirstDayOfYear(indexPath.row+Constants.firstYear) ?? 0)
        return cell
    }
}

extension YearViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.cellSpacing
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.cellSpacing
    }
}
