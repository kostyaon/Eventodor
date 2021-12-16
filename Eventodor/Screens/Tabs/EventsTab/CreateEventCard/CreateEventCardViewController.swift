//
//  CreateEventCardViewController.swift
//  Eventodor
//
//  Created by Petrykevich, Kanstantsin on 14.12.21.
//

import UIKit

class CreateEventCardViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var organizaationTextField: EVENTODORTextField!
    @IBOutlet weak var categoryTextField: EVENTODORTextField!
    @IBOutlet weak var addressTextField: EVENTODORTextField!
    @IBOutlet weak var personsAmountTextField: EVENTODORTextField!
    @IBOutlet weak var nameTextField: EVENTODORTextField!
    @IBOutlet weak var descriptionTextField: EVENTODORTextField!
    @IBOutlet weak var dateTextField: EVENTODORTextField!
    @IBOutlet weak var priceTextField: EVENTODORTextField!
    @IBOutlet weak var createButton: EVENTODORButton!
    
    // MARK: - Lifecycle method's
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dismissKeyboardOnTap = true
        setupUI()
    }
}

// MARK: - Private method's
private
extension CreateEventCardViewController {
    
    @objc func onBgView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupUI() {
        setupCardView()
        setupAction()
        setupText()
    }
    
    func setupText() {
        createButton.setTitle(with: "create_event_title".localized())
        createButton.onTap = { [weak self] in
            AppEnvironment.myEvent = true
            self?.dismiss(animated: true, completion: nil)
        }
        titleLabel.text = "create_event_button".localized()
    }
    
    func setupAction() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onBgView))
        bgView.addGestureRecognizer(tapGesture)
    }
    
    func setupCardView() {
        cardView.layer.cornerRadius = 24
        cardView.layer.shadowOpacity = 0.5
        cardView.layer.shadowOffset = CGSize(width: 0.0, height: 10.0)
        cardView.layer.shadowRadius = 15
    }
}
