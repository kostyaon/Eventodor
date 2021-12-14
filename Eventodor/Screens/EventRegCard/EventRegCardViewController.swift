//
//  EventRegCardViewController.swift
//  Eventodor
//
//  Created by Petrykevich, Kanstantsin on 15.12.21.
//

import UIKit

class EventRegCardViewController: BaseViewController {
    
    // MARK: - Outlet
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var eventLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var registerButton: EVENTODORButton!
    
    // MARK: - Lifecycle method's
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

// MARK: - Private method's
private
extension EventRegCardViewController {
    
    @objc func onBgView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupUI() {
        registerButton.setTitle(with: "Register")
        setupCardView()
        setupAction()
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
