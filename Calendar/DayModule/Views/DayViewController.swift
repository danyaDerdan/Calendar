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
    
    var viewModel: DayViewModelProtocol?
    var scrollView: UIScrollView = UIScrollView()
    var eventBlocks: [UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = false
        title = viewModel?.day?.date
        setUpUI()
        updateView()
        viewModel?.viewDidLoad()
        
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
    }
    
    func setupEvents(events: [EventSettings.Event]) {
        for (index, event) in events.enumerated() {
            addEvent(event, index)
        }
    }
    
    func setUpLines() {
        
        for i in 0..<(viewModel?.hours?.count ?? 0) {
            let line = UIView()
            let label = UILabel()
            label.text = viewModel?.hours?[i].text
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
        eventBlocks.append(block)
        scrollView.scrollRectToVisible(CGRect(x: Constants.blockLeadingInset, y: event.start.timeIntervalSince(start)/Constants.hourHeight - Constants.hourHeight, width: Constants.blockLeadingInset, height: Constants.blockLeadingInset), animated: true)
    }
    
    private func clearEvents() {
        for block in eventBlocks {
            block.removeFromSuperview()
            eventBlocks.removeAll() {$0 == block}
        }
    }
    
    @objc private func buttonTapped(sender: UIButton) {
        viewModel?.buttonTapped(tag: sender.tag)
    }
    
    private func updateView() {
        viewModel?.updateViewData = { [weak self] viewState in
            switch viewState {
            case .data(let viewData):
                self?.clearEvents()
                self?.setupEvents(events: viewData.events)
            case .error:
                self?.clearEvents()
            }
            
        }
    }
}
