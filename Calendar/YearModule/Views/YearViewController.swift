import UIKit

final class YearViewController: UIViewController {
    var viewModel: YearViewModelProtocol?
    
    lazy var collectionView = createCollectionView()
    lazy var plusButton = createPlusButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        navigationController?.navigationBar.isHidden = true
        
        updateView()
        collectionView.delegate = self
        collectionView.dataSource = self
        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
    }
    
    func updateView() {
        viewModel?.updateViewData = { [weak self] in
            self?.collectionView.reloadData()
        }
    }

    @objc func plusButtonTapped() {
        viewModel?.router?.showEventModule(event: nil, onDismiss: nil)
    }
    
}
