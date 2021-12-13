//
//  EVENTODORButton.swift
//  Eventodor
//
//  Created by Petrykevich, Kanstantsin on 13.12.21.
//

import UIKit

class EVENTODORButton: UIButton {
    
    // MARK: - Properties
    var onTap: (() -> ())?
    private var bgColor: UIColor {
        UIColor(red: 230/256, green: 77/256, blue: 77/256, alpha: 1.0)
    }
    
    override var isEnabled: Bool {
        didSet {
            isEnabled ? enableButton() : disableButton()
        }
    }
    
    // MARK: - Lifecycle method's
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - Helper method's
    func setColor(_ color: UIColor) {
        self.backgroundColor = color
    }
    
    func setTitle(with text: String) {
        let attributes = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        let attributedString = NSAttributedString(string: text, attributes: attributes)
        self.setAttributedTitle(attributedString, for: .normal)
    }
}

// MARK: - Private method's
private
extension EVENTODORButton {
    
    @objc func buttonAction() {
        onTap?()
    }
    
    func setupUI() {
        self.backgroundColor = bgColor
        self.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    func enableButton() {
        self.backgroundColor = bgColor
    }
    
    func disableButton() {
        self.backgroundColor = UIColor(red: 255/256, green: 128/256, blue: 128/256, alpha: 0.5)
    }
}
