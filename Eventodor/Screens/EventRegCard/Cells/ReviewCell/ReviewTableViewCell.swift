//
//  ReviewTableViewCell.swift
//  Eventodor
//
//  Created by Petrykevich, Kanstantsin on 25.05.22.
//

import Foundation
import UIKit
import Kingfisher

class ReviewTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    
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
    func configure(with review: Review) {
        usernameLabel.text = review.reviewer
        ratingLabel.text = String(format: "%.1f", review.rank ?? 0.0) + " " + "★"
        reviewLabel.text = review.description
    }
}

// MARK: - Private method's
private
extension ReviewTableViewCell {
    
    func setupUI() {
        setupImageView()
        setupLabels()
    }
    
    func setupImageView() {
        avatarImageView.image = UIImage(named: "head")
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.height / 2
    }
    
    func setupLabels() {
        
    }
}
