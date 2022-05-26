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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15))
    }
    
    // MARK: - Helper method's
    func configure(with event: Event?) {
        guard let event = event else { return }
        descriptionLabel.text = event.description ?? ""
        timeTitleLabel.text = "time_title".localized()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd:MM:yyyy"
        let viewDate = dateFormatter.date(from: event.time ?? "")
        timeLabel.text = dateFormatter.string(from: viewDate ?? Date())
  
        priceTitleLabel.text = "price_title".localized()
        priceLabel.text = "\(String(format: "%.2f", (event.price as? NSString)?.doubleValue ?? 0.0)) бел. руб."
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
