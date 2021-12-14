//
//  EventCardTableViewCell.swift
//  Eventodor
//
//  Created by Petrykevich, Kanstantsin on 14.12.21.
//

import UIKit

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
    
    // MARK: - Lifecycle method's
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    // MARK: - Helper method's
    
}

// MARK: - Private method's
private
extension EventCardTableViewCell {
    
    func setupUI() {
        setupLabels()
        setupImageView()
    }
    
    func setupLabels() {
        organizerNameLabel.font = .boldSystemFont(ofSize: 12)
        organizerNameLabel.textColor = UIColor(red: 83/256, green: 92/256, blue: 94/256, alpha: 1.0)
        organizerNameLabel.text = "Organizer name"
        
        eventNameLabel.font = .boldSystemFont(ofSize: 20)
        eventNameLabel.textColor = .black
        eventNameLabel.text = "Event name"
        
        priceLabel.font = .boldSystemFont(ofSize: 12)
        priceLabel.textColor = .black
        priceLabel.text = "Price"
        
        dateLabel.font = .systemFont(ofSize: 12)
        dateLabel.textColor = UIColor(red: 83/256, green: 92/256, blue: 94/256, alpha: 1.0)
        dateLabel.text = "Date"
        
        moreLabel.font = .boldSystemFont(ofSize: 16)
        moreLabel.textColor = .black
        moreLabel.text = "event_more".localized()
        
        distanceLabel.font = .boldSystemFont(ofSize: 11)
        distanceLabel.textColor = .white
        distanceLabel.text = "4 km"
    }
    
    func setupImageView() {
        distanceCircleImageView.image = distanceCircleImageView.image?.withRenderingMode(.alwaysTemplate)
        distanceCircleImageView.tintColor = UIColor(red: 220/256, green: 0.0, blue: 0.0, alpha: 1.0)
        distanceCircleImageView.layer.shadowOpacity = 0.3
        distanceCircleImageView.layer.shadowOffset = CGSize(width: 0.0, height: 10.0)
        distanceCircleImageView.layer.shadowRadius = 10
    }
}
