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
    
    // MARK: - Actions
    @IBAction func onDonate() {
        print("Tap on Donate button")
    }
    
    @IBAction func onRegister() {
        print("Tap on register button")
    }
    
    // MARK: - Properties
    
    // MARK: - Lifecycle method's
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    // MARK: - Helper method's
    func configure(with organizer: Organizer?) {
        guard let organizer = organizer else { return }
        organizerLabel.text = organizer.name
        emailLabel.text = organizer.email
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
