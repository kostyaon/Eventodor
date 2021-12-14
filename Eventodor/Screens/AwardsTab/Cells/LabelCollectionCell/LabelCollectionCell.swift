//
//  LabelCollectionCell.swift
//  TRYG
//
//  Created by Petrykevich, Kanstantsin on 9.11.21.
//  Copyright © 2021 Scope Technologies. All rights reserved.
//

import UIKit

class LabelCollectionCell: UICollectionViewCell {
    
    // MARK: - Static properties
    static let nib = UINib(nibName: "LabelCollectionCell", bundle: nil)
    static let reuseId = "LabelCollectionCell"
    
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var rectView: UIView!
    
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
extension LabelCollectionCell {
    
    func setupUI() {
        setupContentView()
        setupRectView()
        setupLabel()
    }
    
    func setupRectView() {
        rectView.layer.cornerRadius = 2
    }
    
    func setupContentView() {
        bgView.layer.cornerRadius = 24
        bgView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    func setupLabel() {
        titleLabel.font = .boldSystemFont(ofSize: 27)
        titleLabel.textColor = .black
        titleLabel.text = "awards_collection".localized()
    }
}
