//
//  RewardCollectionCell.swift
//  TRYG
//
//  Created by Petrykevich, Kanstantsin on 8.11.21.
//  Copyright © 2021 Scope Technologies. All rights reserved.
//

import UIKit

class RewardCollectionCell: UICollectionViewCell {
    
    // MARK: - Static properties
    static let nib = UINib(nibName: "RewardCollectionCell", bundle: nil)
    static let reuseId = "RewardCollectionCell"
    
    // MARK: - Outlets
    @IBOutlet weak var bgCardView: UIView!
    @IBOutlet weak var cardEdgesView: UIView!
    @IBOutlet weak var achievedAwardImageView: UIImageView!
    @IBOutlet weak var awardImageView: UIImageView!
    @IBOutlet weak var awardNameLabel: UILabel!
    @IBOutlet weak var describingLabel: UILabel!
    
    // MARK: - Lifecycle method's
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
        setupCell()
    }
    
    // MARK: - Helper method's
    func configureCell(text: String, imageName: String) {
        awardNameLabel.text = text
     //   awardImageView.image = UIImage(named: imageName)
        describingLabel.text = "\("awards_proud".localized())"
    }
}

// MARK: - Private method's
private
extension RewardCollectionCell {
    
    func setupUI() {
        setupBgCardView()
        setupLabels()
    }
    
    func setupLabels() {
        let awardNameAttributedText = awardNameLabel.text?.addLineSpacing(spacing: 4, textAllignment: .center)
        let describingAttributedText = describingLabel.text?.addLineSpacing(spacing: 4, textAllignment: .center)
        describingLabel.attributedText = describingAttributedText
        awardNameLabel.attributedText = awardNameAttributedText
    }
    
    func setupBgCardView() {
        bgCardView.layer.cornerRadius = 24
        bgCardView.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        bgCardView.layer.shadowRadius = 3
        bgCardView.layer.shadowOpacity = 0.1
    }
    
    func setupCell() {
        cardEdgesView.alpha = 0.0
        bgCardView.backgroundColor = .white
        bgCardView.layer.shadowOpacity = 0.1
        achievedAwardImageView.alpha = 1.0
    }
}
