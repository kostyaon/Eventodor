//
//  CardCellTableViewCell.swift
//  Eventodor
//
//  Created by Petrykevich, Kanstantsin on 24.05.22.
//

import Foundation
import UIKit
import Kingfisher

class CardCellTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var participantCountLabel: UILabel!
    
    // MARK: - Properties
    
    // MARK: - Lifecycle method's
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0))
    }
    
    // MARK: - Helper method's
    func configure(with event: Event?) {
        guard let event = event else { return }
        if let url = event.photo?.url {
            cardImageView.kf.setImage(with: URL(string: url))
        }
        eventNameLabel.text = event.name
        if let distance = event.distance {
            distanceLabel.text = "\(String(format: "%.2f", distance / 1000)) км"
        } else {
            distanceLabel.text = "МОЕ"
        }
        ratingLabel.text = String(format: "%.1f", event.rank ?? 0.0) + " " + "★"
        participantCountLabel.text = "Участников: \(event.register_persons_amount ?? 0)/\(event.persons_amount ?? 0)"
    }
}

// MARK: - Private method's
private
extension CardCellTableViewCell {
    
    func setupUI() {
        setupImageView()
    }
    
    func setupImageView() {
        cardImageView.image = UIImage(named: "gradient")
    }
}
