//
//  EVENTODORTextField.swift
//  Eventodor
//
//  Created by Petrykevich, Kanstantsin on 13.12.21.
//

import UIKit

class EVENTODORTextField: UITextField {
    
    // MARK: - Properties
    private var textFieldColor: UIColor {
        .init(red: 247/256, green: 247/256, blue: 247/256, alpha: 1.0)
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
}

// MARK: - Private method's
private
extension EVENTODORTextField {
    
    func setupUI() {
        self.backgroundColor = textFieldColor
        self.layer.cornerRadius = 12
    }
}
