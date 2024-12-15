import UIKit

final class YearViewController: UIViewController {
    var viewModel: YearViewModelProtocol!
    
    lazy var collectionView = createCollectionView()
    lazy var plusButton = createPlusButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
    }

    @objc func plusButtonTapped() {
        
    }
    
}
