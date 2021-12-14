//
//  EventsViewController.swift
//  Eventodor
//
//  Created by Petrykevich, Kanstantsin on 14.12.21.
//

import UIKit

class EventsViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var createImageView: UIImageView!
    @IBOutlet weak var filterImageView: UIImageView!
    
    // MARK: - Lifecycle method's
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
    }
    
    func setupUI() {
        setupTableView()
        setupTitle()
        setupActions()
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
        titleLabel.text = "event_title".localized()
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
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withType: EventCardTableViewCell.self, for: indexPath)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    }
}
