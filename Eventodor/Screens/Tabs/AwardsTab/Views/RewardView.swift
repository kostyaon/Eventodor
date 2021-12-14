//
//  RewardView.swift
//  TRYG
//
//  Created by Petrykevich, Kanstantsin on 28.10.21.
//  Copyright © 2021 Scope Technologies. All rights reserved.
//

import UIKit

class RewardView: UIView {
    
    // MARK: - Outlets
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var rewardImageView: UIImageView!
    @IBOutlet weak var rewardLabel: UILabel!
    
    // MARK: - Properties
    private let labelFont: UIFont = .boldSystemFont(ofSize: 10)
    
    // MARK: - Lifecycle method's
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
        setupUI()
    }
    
    // MARK: - Private method's
    private func commonInit() {
        Bundle.main.loadNibNamed("RewardView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    private func setupUI() {
        rewardLabel.font = labelFont
        rewardLabel.textColor = .black
        rewardLabel.textAlignment = .center
        rewardLabel.numberOfLines = 0
        rewardImageView.contentMode = .scaleAspectFit
    }
    
    // MARK: - Helper method's
    func configureView(name: String, imageName: String) {
        let attributedText = name.addLineSpacing(spacing: 8, textAllignment: .center)
        rewardLabel.attributedText = attributedText
        rewardImageView.image = UIImage(named: imageName)
    }
}
