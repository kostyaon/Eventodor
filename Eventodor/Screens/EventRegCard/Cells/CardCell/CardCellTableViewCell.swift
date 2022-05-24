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
    
    // MARK: - Helper method's
    func configure(with event: Event?) {
        guard let event = event else { return }
        cardImageView.kf.setImage(with: URL(string: event.photo?.url ?? ""))
        eventNameLabel.text = event.name
        distanceLabel.text = "\(event.distance ?? 0.0) km"
        ratingLabel.text = event.rank ?? "" + " " + "*"
        participantCountLabel.text = "\(event.register_persons_amount ?? 0)/\(event.persons_amount ?? 0)"
    }
}

// MARK: - Private method's
private
extension CardCellTableViewCell {
    
    func setupUI() {
        setupLabels()
    }
    
    func setupLabels() {
        
    }
}
