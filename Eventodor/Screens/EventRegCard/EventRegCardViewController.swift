//
//  EventRegCardViewController.swift
//  Eventodor
//
//  Created by Petrykevich, Kanstantsin on 15.12.21.
//

import UIKit

class EventRegCardViewController: BaseViewController {
    
    // MARK: - Outlet
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Properties
    var event: Event?
    private var eventReviews: [Review] = []
    private let viewModel = EventRegCardViewModel(isRequestGroup: true)
    
    // MARK: - Lifecycle method's
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadData()
    }
    
    // MARK: - Override handlers
    override func handleError() {
        viewModel.presentError = { [weak self] message in
            guard let this = self else { return }
            this.showError(title: "error_title".localized(), message: message)
        }
    }
    
    override func handleUpdateUI() {
        viewModel.updateUI = { [weak self] in
            guard let this = self else { return }
            this.eventReviews = this.viewModel.reviews
            this.event?.rank = "\(this.viewModel.rank ?? 0.0)"
            this.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate
extension EventRegCardViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0...2:
            return 1
        case 3:
            return eventReviews.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withType: CardCellTableViewCell.self, for: indexPath)
            cell.configure(with: event)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withType: DescriptionTableViewCell.self, for: indexPath)
            cell.configure(with: event)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withType: OrganizerTableViewCell.self, for: indexPath)
            cell.configure(with: event?.organizer)
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withType: ReviewTableViewCell.self, for: indexPath)
            cell.configure(with: eventReviews[indexPath.row])
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Tap on \(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 220
        case 2:
            return 102
        case 3:
            return 120
        default:
            return 70
        }
    }
}

// MARK: - Private method's
private
extension EventRegCardViewController {
    
    func loadData() {
        viewModel.eventId = event?.id ?? 0
        viewModel.getReview()
    }
    
    func setupUI() {
        setupTableView()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 25
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(nibWithClass: CardCellTableViewCell.self)
        tableView.register(nibWithClass: DescriptionTableViewCell.self)
        tableView.register(nibWithClass: OrganizerTableViewCell.self)
        tableView.register(nibWithClass: ReviewTableViewCell.self)
    }
}
