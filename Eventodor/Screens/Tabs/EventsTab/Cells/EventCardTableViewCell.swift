//
//  EventCardTableViewCell.swift
//  Eventodor
//
//  Created by Petrykevich, Kanstantsin on 14.12.21.
//

import UIKit
import Kingfisher

class EventCardTableViewCell: UITableViewCell {
    
    // MARK: - Outlet
    @IBOutlet weak var organizerNameLabel: UILabel!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var distanceCircleImageView: UIImageView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var eventPhotoImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var moreLabel: UILabel!
    
    // MARK: - Properties
    var onReviewTap: Closure?
    
    // MARK: - Lifecycle method's
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // eventPhotoImageView.image = nil
    }
    
    // MARK: - Helper method's
    func configureCell(event: Event, type: EventsViewController.EventState) {
        if let distance = event.distance {
            let viewDistance = String(format: "%.2f", distance / 1000)
            distanceLabel.text = "\(viewDistance)"
        } else {
            distanceLabel.text = "MY"
        }
        
        if type == .myEvents {
            moreLabel.text = "set_review_label".localized()
            reviewAction()
        }
        
        if let url = event.photo?.url {
            eventPhotoImageView.kf.setImage(with: URL(string: url))
        }
        organizerNameLabel.text = event.organizer?.name ?? ""
        eventNameLabel.text = event.name
        descriptionLabel.text = event.description
        priceLabel.text = "Price: \(event.price ?? "") dollars"
        dateLabel.text = "Date: " + (event.time ?? "")
    }
}

// MARK: - Private method's
private
extension EventCardTableViewCell {
    
    // @objc method's
    @objc func onReview() {
        onReviewTap?()
    }
    
    // Method's
    func reviewAction() {
        moreLabel.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onReview))
        moreLabel.addGestureRecognizer(tapGesture)
    }
    
    func setupUI() {
        setupLabels()
        setupImageView()
    }
    
    func setupLabels() {
        organizerNameLabel.font = .boldSystemFont(ofSize: 14)
        organizerNameLabel.textColor = UIColor(red: 83/256, green: 92/256, blue: 94/256, alpha: 1.0)
        organizerNameLabel.text = "Organizer name"
        
        eventNameLabel.font = .boldSystemFont(ofSize: 20)
        eventNameLabel.textColor = .black
        eventNameLabel.text = "Event name"
        
        priceLabel.font = .boldSystemFont(ofSize: 15)
        priceLabel.textColor = .black
        priceLabel.text = "Price"
        
        dateLabel.font = .systemFont(ofSize: 13)
        dateLabel.textColor = UIColor(red: 83/256, green: 92/256, blue: 94/256, alpha: 1.0)
        dateLabel.text = "Date"
        
        moreLabel.font = .boldSystemFont(ofSize: 14)
        moreLabel.textColor = .black
        moreLabel.text = "event_more".localized()
        
        distanceLabel.font = .boldSystemFont(ofSize: 11)
        distanceLabel.textColor = .white
        distanceLabel.text = "4 km"
    }
    
    func setupImageView() {
        eventPhotoImageView.image = UIImage(named: "gradient")
        distanceCircleImageView.image = distanceCircleImageView.image?.withRenderingMode(.alwaysTemplate)
        distanceCircleImageView.tintColor = UIColor(red: 220/256, green: 0.0, blue: 0.0, alpha: 1.0)
        distanceCircleImageView.layer.shadowOpacity = 0.3
        distanceCircleImageView.layer.shadowOffset = CGSize(width: 0.0, height: 10.0)
        distanceCircleImageView.layer.shadowRadius = 10
    }
}
