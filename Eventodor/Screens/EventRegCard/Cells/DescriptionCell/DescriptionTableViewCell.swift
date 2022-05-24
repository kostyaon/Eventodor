//
//  DescriptionTableViewCell.swift
//  Eventodor
//
//  Created by Petrykevich, Kanstantsin on 24.05.22.
//

import Foundation
import UIKit

class DescriptionTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var timeTitleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var priceTitleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    // MARK: - Properties
    
    // MARK: - Lifecycle method's
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    // MARK: - Helper method's
    func configure(with event: Event?) {
        guard let event = event else { return }
        descriptionLabel.text = event.description
        timeTitleLabel.text = "time_title".localized()
        timeLabel.text = event.time ?? ""
        priceTitleLabel.text = "price_title".localized()
        priceLabel.text = event.price ?? "" + "currency_symbol".localized()
    }
}

// MARK: - Private method's
private
extension DescriptionTableViewCell {
    
    func setupUI() {
        setupLabels()
    }
    
    func setupLabels() {
        
    }
}
