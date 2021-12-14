//
//  CategoryTableViewCell.swift
//  Eventodor
//
//  Created by Petrykevich, Kanstantsin on 14.12.21.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    // MARK: - Lifecycle method's
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        selected ? selectedStyle() : deselectedStyle()
    }
    
    // MARK: - Helper method's
    func configureCell(with text: String) {
        categoryNameLabel.text = text
    }
}

// MARK: - Private method's
private
extension CategoryTableViewCell {
    
    func selectedStyle() {
        categoryNameLabel.isEnabled = true
    }
    
    func deselectedStyle() {
        categoryNameLabel.isEnabled = false
    }
    
    func setupUI() {
        categoryNameLabel.font = .boldSystemFont(ofSize: 14)
        categoryNameLabel.textColor = .black
    }
}
