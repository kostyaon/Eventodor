//
//  EVENTODORCheckbox.swift
//  Eventodor
//
//  Created by Petrykevich, Kanstantsin on 14.12.21.
//

import UIKit

class EVENTODORCheckbox: UIView {
    
    // MARK: - Properties
    private lazy var shapeLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.frame = self.layer.bounds
        layer.fillColor = UIColor.white.cgColor
        layer.strokeColor = UIColor(red: 159/256, green: 31/256, blue: 21/256, alpha: 1.0).cgColor
        layer.lineWidth = 1
        return layer
    }()
    var isEnabled: Bool = false {
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
    
}

// MARK: - Private method's
private
extension EVENTODORCheckbox {
    
    @objc func buttonAction() {
        isEnabled.toggle()
    }
    
    func setupUI() {
        let path = UIBezierPath(roundedRect: self.layer.bounds, cornerRadius: 3)
        shapeLayer.path = path.cgPath
        self.layer.insertSublayer(shapeLayer, at: 0)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(buttonAction))
        self.addGestureRecognizer(tapGesture)
    }
    
    func enableButton() {
        shapeLayer.fillColor = UIColor(red: 159/256, green: 31/256, blue: 21/256, alpha: 1.0).cgColor
    }
    
    func disableButton() {
        shapeLayer.fillColor = UIColor.white.cgColor
    }
}
