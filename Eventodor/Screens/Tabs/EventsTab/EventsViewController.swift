//
//  EventsViewController.swift
//  Eventodor
//
//  Created by Petrykevich, Kanstantsin on 14.12.21.
//

import UIKit

class EventsViewController: BaseViewController {
    
    // MARK: - EventState
    enum EventState {
        
        case events
        case myEvents
    }
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var createImageView: UIImageView!
    @IBOutlet weak var filterImageView: UIImageView!
    
    // MARK: - Properties
    private var eventState: EventState = .events
    private var events: [Event] = []
    private var myEvents: [Event] = [
        Event(event_id: nil, photo: nil, organizer: "OrganizeBEL", coordinate: nil, category: nil, address: nil, persons_amount: nil, register_persons_amount: nil, name: "New Year Eve", descriptioin: "We wish you a merry Christmas and a Happy New Year", time: "31.12.2021 23:00", price: 20.0, rank: nil),
        Event(event_id: nil, photo: nil, organizer: "OrganizeRU", coordinate: nil, category: nil, address: nil, persons_amount: nil, register_persons_amount: nil, name: "Only for russians", descriptioin: "We will road across Russia to see beautiful places", time: "05.01.2022 10:00", price: 800.0, rank: nil),
        Event(event_id: nil, photo: nil, organizer: "OrganizeSWISS", coordinate: nil, category: nil, address: nil, persons_amount: nil, register_persons_amount: nil, name: "Skiing and snowboarding", descriptioin: "If you like skiing and snowboarding around the nature, you're welcome!", time: "13.02.2022 12:25", price: 3500.0, rank: nil)
    ]
    
    // MARK: - Lifecycle method's
    init(eventState: EventsViewController.EventState) {
        self.eventState = eventState
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

// MARK: - Private method's
private
extension EventsViewController {
    
    @objc func onCreate() {
        print("Create event")
        let createCardViewController = CreateEventCardViewController()
        createCardViewController.modalPresentationStyle = .overCurrentContext
        self.present(createCardViewController, animated: true, completion: nil)
    }
    
    @objc func onFilter() {
        print("Filter events")
        let filterCardViewController = FilterEventCardViewController()
        filterCardViewController.modalPresentationStyle = .overCurrentContext
        self.present(filterCardViewController, animated: true, completion: nil)
    }
    
    func setupUI() {
        setupTableView()
        setupTitle()
        if eventState == .events {
            setupActions()
        } else {
            createImageView.isHidden = true
            filterImageView.isHidden = true
        }
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 425
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(nibWithClass: EventCardTableViewCell.self)
    }
    
    func setupTitle() {
        titleLabel.font = .boldSystemFont(ofSize: 30)
        titleLabel.textColor = .black
        if eventState == .events {
            titleLabel.text = "event_title".localized()
        } else {
            titleLabel.text = "my_event_title".localized()
        }
       
    }
    
    func setupActions() {
        let onCreateGesture = UITapGestureRecognizer(target: self, action: #selector(onCreate))
        createImageView.addGestureRecognizer(onCreateGesture)
        
        let onFilterGesture = UITapGestureRecognizer(target: self, action: #selector(onFilter))
        filterImageView.addGestureRecognizer(onFilterGesture)
    }
}

// MARK: - TableView method's
extension EventsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if eventState == .events {
            return 10
        } else {
            return myEvents.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withType: EventCardTableViewCell.self, for: indexPath)
        if eventState == .myEvents {
            cell.configureCell(event: myEvents[indexPath.row], distance: nil)
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if eventState == .myEvents {
            let reviewViewController = ReviewViewController()
            reviewViewController.modalPresentationStyle = .overCurrentContext
            self.present(reviewViewController, animated: true, completion: nil)
        } else {
            let registerViewController = EventRegCardViewController()
            registerViewController.modalPresentationStyle = .overCurrentContext
            self.present(registerViewController, animated: true, completion: nil)
        }
    }
}
