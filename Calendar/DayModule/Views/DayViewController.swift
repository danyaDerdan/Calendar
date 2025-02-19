import UIKit

private struct Constants {
    static let hoursCount = 24
    static let hourHeight: CGFloat = 60
    static let defaultInset: CGFloat = 10
    static let lineHeight: CGFloat = 1
    static let blockAlpha = 0.3
    static let blockCornerRadius: CGFloat = 10
    static let blockLabelFont = UIFont.boldSystemFont(ofSize: 20)
    static let blockLeftPadding: CGFloat = 30
    static let blockLeadingInset: CGFloat = 100
}

final class DayViewController: UIViewController {
    
    var viewModel: DayViewModel?
    var scrollView: UIScrollView = UIScrollView()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = false
        title = viewModel?.day?.date
        setUpUI()
        updateView()
    }
    
    func setUpUI() {
        scrollView.alwaysBounceVertical = true
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize = CGSize(width: view.frame.width, height: CGFloat(Constants.hoursCount) * Constants.hourHeight)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ])
        setUpLines()
        guard let viewModel else { return }
        for (index, event) in viewModel.getEvents().enumerated() {
            addEvent(event, index)
        }
    }
    
    func setUpLines() {
        
        for i in 0..<Constants.hoursCount {
            let line = UIView()
            let label = UILabel()
            label.text = viewModel?.getStringHour(i)
            label.textColor = .systemGray2
            line.backgroundColor = .systemGray4
            
            scrollView.addSubview(line)
            scrollView.addSubview(label)
            
            line.translatesAutoresizingMaskIntoConstraints = false
            label.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                line.heightAnchor.constraint(equalToConstant: Constants.lineHeight),
                line.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
                line.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: Constants.hourHeight),
                line.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: CGFloat((i+1))*Constants.hourHeight),
                
                label.trailingAnchor.constraint(equalTo: line.leadingAnchor, constant: -Constants.defaultInset),
                label.centerYAnchor.constraint(equalTo: line.centerYAnchor)
                ])
        }
    }
    
    func addEvent(_ event: EventSettings.Event, _ index: Int) {
        let block = UIButton(type: .system)
        block.backgroundColor = .systemCyan.withAlphaComponent(Constants.blockAlpha)
        block.layer.cornerRadius = Constants.blockCornerRadius
        
        let height = event.start.distance(to: event.end)/Constants.hourHeight
        let start = Calendar.current.startOfDay(for: event.start)
        
        block.setTitle(event.name, for: .normal)
        block.titleLabel?.font = Constants.blockLabelFont
        block.titleLabel?.textAlignment = .center
        block.contentHorizontalAlignment = .left
        block.titleEdgeInsets = UIEdgeInsets(top: Constants.defaultInset,
                                             left: Constants.blockLeftPadding,
                                             bottom: Constants.defaultInset,
                                             right: Constants.defaultInset)
        block.titleLabel?.textColor = .systemCyan
        block.isEnabled = true
        block.tag = index

        block.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(block)
        NSLayoutConstraint.activate([
            block.heightAnchor.constraint(equalToConstant: height),
            block.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            block.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: Constants.blockLeadingInset),
            block.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: event.start.timeIntervalSince(start)/Constants.hourHeight + Constants.hourHeight)
        ])
        block.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        scrollView.scrollRectToVisible(CGRect(x: Constants.blockLeadingInset, y: event.start.timeIntervalSince(start)/Constants.hourHeight - Constants.hourHeight, width: Constants.blockLeadingInset, height: Constants.blockLeadingInset), animated: true)
    }
    
    @objc func buttonTapped(sender: UIButton) {
        viewModel?.router?.showEventModule(event: viewModel?.getEvents()[sender.tag])
    }
    
    func updateView() {
        viewModel?.updateViewData = { [weak self] in
            self?.scrollView.removeFromSuperview()
            self?.setUpUI()
        }
    }
}
