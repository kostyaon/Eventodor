//
//  ReviewViewController.swift
//  Eventodor
//
//  Created by Petrykevich, Kanstantsin on 14.12.21.
//

import UIKit

class ReviewViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleTextViewLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var sendButton: EVENTODORButton!
    
    // MARK: - Properties
    
    // MARK: - Lifecycle method's
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dismissKeyboardOnTap = true
        setupUI()
    }
}

// MARK: - Private method's
private
extension ReviewViewController {
    
    @objc func onBgView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupUI() {
        setupCardView()
        setupAction()
        setupLabels()
        setupButton()
        setupTextView()
    }
    
    func setupLabels() {
        titleLabel.text = "review_title".localized()
        titleTextViewLabel.text = "review_title".localized()
    }
    
    func setupTextView() {
        textView.layer.cornerRadius = 12
    }
    
    func setupButton() {
        sendButton.setTitle(with: "review_send".localized())
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
