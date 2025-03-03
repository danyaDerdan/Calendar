import UIKit

final class SettingsViewController: UIViewController {
    var viewModel: SettingsViewModel?
    lazy var imageView = createImageView()
    lazy var nameView = createNameView()
    lazy var birthdayView = createBirthdayView()
    lazy var colorView = createColorView()
    lazy var soundView = createSoundView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        soundView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        viewModel?.viewWillDissappear(name: nameView.textField?.text,
                                      birthday: birthdayView.datePicker?.date,
                                      themeColor: getSelectedColor(),
                                      notificationSound: getSelectedSound())
        super.viewWillDisappear(animated)
    }
    
    
    
    
}
