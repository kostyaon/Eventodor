//
//  ReviewViewController.swift
//  Eventodor
//
//  Created by Petrykevich, Kanstantsin on 14.12.21.
//

import UIKit

class ReviewViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleTextViewLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var sendButton: EVENTODORButton!
    
    // MARK: - Properties
    var event: Event?
    private let viewModel = ReviewViewModel(isRequestGroup: true)
    
    // MARK: - Lifecycle method's
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dismissKeyboardOnTap = true
        setupUI()
    }
    
    // MARK: - Override handlers
    override func handleError() {
        viewModel.presentError = { [weak self] message in
            guard let this = self else { return }
            this.showError(title: "error_title".localized(), message: message)
        }
    }
    
    override func handleUpdateUI() {
        viewModel.updateUI = { [weak self] in
            guard let this = self else { return }
            this.showError(title: "error_success".localized(), message: "create_review_success".localized())
        }
    }
}

// MARK: - Private method's
private
extension ReviewViewController {
    
    // @objc method's
    @objc func onMainView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // Method's
    func sendReview() {
        guard let event = event else {
            showError(title: "error_title", message: "app_error".localized())
            return
        }
        let sliderValue = String(format: "%.1f", slider.value)
        viewModel.sendReview(eventId: event.id ?? 1, description: textView.text, rank: Float(sliderValue) ?? 0.0)
    }
    
    func setupMainView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onMainView))
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(tapGesture)
    }
    
    func setupUI() {
        setupMainView()
        setupCardView()
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
        sendButton.setColor(.rgba(172, 206, 226))
        sendButton.setTitle(with: "review_send".localized())
        sendButton.onTap = { [weak self] in
            guard let this = self else { return }
            if this.textView.text.isEmpty {
                this.showError(title: "error_title".localized(), message: "review_field_empty".localized())
            }
            this.sendReview()
        }
    }
    
    func setupCardView() {
        cardView.layer.cornerRadius = 24
        cardView.layer.shadowOpacity = 0.5
        cardView.layer.shadowOffset = CGSize(width: 0.0, height: 10.0)
        cardView.layer.shadowRadius = 15
    }
}
