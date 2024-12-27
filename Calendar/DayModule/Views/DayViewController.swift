import UIKit

final class DayViewController: UIViewController {
    
    var viewModel: DayViewModel!
    var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = false
        title = viewModel.day.date
        setUpUI()
        updateView()
    }
    
    func setUpUI() {
        
        
        scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize = CGSize(width: view.frame.width, height: 24 * 60)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ])
        setUpLines()
        
        for (index, event) in viewModel.getEvents().enumerated() {
            addEvent(event, index)
        }
    }
    
    func setUpLines() {
        
        for i in 0..<24 {
            let line = UIView()
            let label = UILabel()
            label.text = "\(i > 9 ? String(i) : "0" + String(i)).00"
            label.textColor = .systemGray2
            line.backgroundColor = .systemGray4
            
            scrollView.addSubview(line)
            scrollView.addSubview(label)
            
            line.translatesAutoresizingMaskIntoConstraints = false
            label.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                line.heightAnchor.constraint(equalToConstant: 1),
                line.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
                line.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 60),
                line.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: CGFloat((i+1)*60)),
                
                label.trailingAnchor.constraint(equalTo: line.leadingAnchor, constant: -10),
                label.centerYAnchor.constraint(equalTo: line.centerYAnchor)
                ])
        }
    }
    
    func addEvent(_ event: EventSettings.Event, _ index: Int) {
        let block = UIButton(type: .system)
        block.backgroundColor = .systemCyan.withAlphaComponent(0.3)
        block.layer.cornerRadius = 10
        
        let height = event.start.distance(to: event.end)/60
        let start = Calendar.current.startOfDay(for: event.start)
        
        block.setTitle(event.name, for: .normal)
        block.titleLabel?.font = .boldSystemFont(ofSize: 20)
        block.titleLabel?.textAlignment = .center
        block.contentHorizontalAlignment = .left
        block.titleEdgeInsets = UIEdgeInsets(top: 10, left: 30, bottom: 10, right: 10)
        block.titleLabel?.textColor = .systemCyan
        block.isEnabled = true
        block.tag = index

        block.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(block)
        NSLayoutConstraint.activate([
            block.heightAnchor.constraint(equalToConstant: height),
            block.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            block.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 100),
            block.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: event.start.timeIntervalSince(start)/60 + 60)
        ])
        block.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        scrollView.scrollRectToVisible(CGRect(x: 100, y: event.start.timeIntervalSince(start)/60 - 60, width: 100, height: 100), animated: true)
    }
    
    @objc func buttonTapped(sender: UIButton) {
        viewModel.router.showEventModule(event: viewModel.getEvents()[sender.tag])
    }
    
    func updateView() {
        viewModel.updateViewData = { [weak self] in
            self?.scrollView.removeFromSuperview()
            self?.setUpUI()
        }
    }
}
