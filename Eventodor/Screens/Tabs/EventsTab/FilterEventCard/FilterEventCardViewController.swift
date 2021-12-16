//
//  FilterEventCardViewController.swift
//  Eventodor
//
//  Created by Petrykevich, Kanstantsin on 14.12.21.
//

import UIKit

class FilterEventCardViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateTextField: EVENTODORTextField!
    @IBOutlet weak var priceTextField: EVENTODORTextField!
    @IBOutlet weak var filterButton: EVENTODORButton!
    
    // MARK: - Properties
    var onFilter: ((Float, String) -> ())?
    
    // MARK: - Lifecycle method's
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dismissKeyboardOnTap = true
        setupUI()
    }
}

// MARK: - Private method's
private
extension FilterEventCardViewController {
    
    @objc func onBgView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupUI() {
        setupCardView()
        setupAction()
        setupText()
    }
    
    func setupText() {
        filterButton.setTitle(with: "filter_event_title".localized())
        filterButton.onTap = { [weak self] in
            self?.onFilter?((self?.priceTextField.text as NSString?)?.floatValue ?? 0.0, self?.dateTextField.text ?? "")
            self?.dismiss(animated: true, completion: nil)
        }
        titleLabel.text = "filter_event_button".localized()
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
