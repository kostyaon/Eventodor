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
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var categoryButton: EVENTODORButton!
    @IBOutlet weak var priceTextField: EVENTODORTextField!
    @IBOutlet weak var filterButton: EVENTODORButton!
    
    // MARK: - Properties
    var onFilter: ((Float, Date) -> ())?
    var onCategory: Closure?
    
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
        setupButtons()
        setupCardView()
        setupAction()
        setupText()
    }
    
    func setupButtons() {
        categoryButton.onTap = { [weak self] in
            guard let this = self else { return }
            this.onCategory?()
            this.dismiss(animated: true, completion: nil)
        }
        filterButton.onTap = { [weak self] in
            guard let this = self else { return }
            this.onFilter?(Float((this.priceTextField.text as? NSString)?.doubleValue ?? 0.0), this.datePicker.date)
            this.dismiss(animated: true, completion: nil)
        }
    }
    
    func setupText() {
        filterButton.setTitle(with: "filter_event_title".localized())
        categoryButton.setTitle(with: "categoty_choose_title".localized())
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
