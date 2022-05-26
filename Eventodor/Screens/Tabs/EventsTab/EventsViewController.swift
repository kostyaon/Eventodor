//
//  EventsViewController.swift
//  Eventodor
//
//  Created by Petrykevich, Kanstantsin on 14.12.21.
//

import UIKit
import CoreLocation

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
    private var myEvents: [Event] = []
    private var viewModel = EventsViewModel(isRequestGroup: true)
    
    // MARK: - Location properties
    private let locationManager = CLLocationManager()
    private var isCurrentLocationEnabled = false
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        isCurrentLocationEnabled = false
        startUpdatingLocation()
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
            this.events = this.viewModel.availableEvents
            this.myEvents = this.viewModel.myEvents
            this.tableView.reloadData()
        }
    }
}

// MARK: - Private method's
private
extension EventsViewController {
    
    // @objc method's
    @objc func onCreate() {
        print("Create event")
        let createCardViewController = CreateEventCardViewController()
        self.present(createCardViewController, animated: true, completion: nil)
    }
    
    @objc func onFilter() {
        print("Filter events")
        let filterCardViewController = FilterEventCardViewController()
        filterCardViewController.modalPresentationStyle = .overCurrentContext
        filterCardViewController.onFilter = { [weak self] (price, date) in
            self?.events.removeAll {
                ((($0.price as? NSString)?.floatValue ?? 0.0) > price) && $0.time != date
            }
            self?.tableView.reloadData()
        }
        self.present(filterCardViewController, animated: true, completion: nil)
    }
    
    // Location method's
    func startUpdatingLocation() {
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    // Method's
    func loadData() {
        viewModel.getEvents()
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
        switch eventState {
        case .events:
            return events.count
        case .myEvents:
            return myEvents.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withType: EventCardTableViewCell.self, for: indexPath)
        if eventState == .myEvents {
            cell.configureCell(event: myEvents[indexPath.row], type: eventState)
            cell.onReviewTap = { [weak self] in
                guard let this = self else { return }
                let reviewController = ReviewViewController()
                reviewController.modalPresentationStyle = .overFullScreen
                this.present(reviewController, animated: true)
            }
        } else {
            cell.configureCell(event: events[indexPath.row], type: eventState)
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cardViewController = EventRegCardViewController()
        switch eventState {
        case .events:
            cardViewController.event = events[indexPath.row]
        case .myEvents:
            cardViewController.event = myEvents[indexPath.row]
        }
        self.navigationController?.pushViewController(cardViewController, animated: true)
    }
}

// MARK: - CLLocationManagerDelegate
extension EventsViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        if !isCurrentLocationEnabled {
            isCurrentLocationEnabled = true
            viewModel.currentLocation = location
            locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        showError(title: "error_title".localized(), message: "location_error".localized())
        print("Error - locationManager: \(error.localizedDescription)")
    }
}
