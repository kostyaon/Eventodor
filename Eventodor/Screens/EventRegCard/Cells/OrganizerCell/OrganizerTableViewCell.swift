//
//  OrganizerTableViewCell.swift
//  Eventodor
//
//  Created by Petrykevich, Kanstantsin on 24.05.22.
//

import Foundation
import UIKit

class OrganizerTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var organizerTitleLabel: UILabel!
    @IBOutlet weak var organizerLabel: UILabel!
    @IBOutlet weak var emailTitleLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var supportLabel: UILabel!
    @IBOutlet weak var donateButton: EVENTODORButton!
    @IBOutlet weak var registerButton: EVENTODORButton!
    
    // MARK: - Properties
    var onRegisterButton: Closure?
    private var bankAccountDonate: String?
    
    // MARK: - Actions
    @IBAction func onDonate() {
        print("Tap on Donate button")
        guard let bankAccountDonate = bankAccountDonate else {
            return
        }
        supportLabel.text = bankAccountDonate
    }
    
    @IBAction func onRegister() {
        print("Tap on register button")
        onRegisterButton?()
    }
    
    // MARK: - Properties
    
    // MARK: - Lifecycle method's
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15))
    }
    
    // MARK: - Helper method's
    func configure(with event: Event?) {
        guard let event = event, let organizer = event.organizer else { return }
        if (event.register_persons_amount ?? 0) == (event.persons_amount ?? 0) {
            registerButton.isEnabled = false
        } else {
            registerButton.isEnabled = true
        }
        organizerLabel.text = organizer.name
        emailLabel.text = organizer.email
        bankAccountDonate = event.organizer?.bankAccount ?? "donate_description".localized()
    }
}

// MARK: - Private
private
extension OrganizerTableViewCell {
    
    func setupUI() {
        setupLabels()
    }
    
    func setupLabels() {
        organizerTitleLabel.text = "organizer_title".localized()
        emailTitleLabel.text = "email_title".localized()
        supportLabel.text = "donate_description".localized()
        donateButton.setTitle(with: "donate_title".localized())
        registerButton.setTitle(with: "register_title".localized())
    }
}
