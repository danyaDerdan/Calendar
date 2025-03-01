import UIKit

final class YearViewController: UIViewController {
    var viewModel: YearViewModelProtocol?
    
    lazy var collectionView = createCollectionView()
    lazy var plusButton = createPlusButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        
        updateView()
        collectionView.delegate = self
        collectionView.dataSource = self
        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: createSettingsButton())
    }
    
    func updateView() {
        viewModel?.updateViewData = { [weak self] in
            self?.collectionView.reloadData()
        }
    }

    @objc func plusButtonTapped() {
        viewModel?.plusButtonTapped()
    }
    
    @objc func settingsButtonTapped() {
        viewModel?.settingsButtonTapped()
    }
}
