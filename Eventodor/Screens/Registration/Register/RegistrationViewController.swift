//
//  RegistrationViewController.swift
//  Eventodor
//
//  Created by Petrykevich, Kanstantsin on 13.12.21.
//

import UIKit

class RegistrationViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var registrationLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var surnameLabel: UILabel!
    @IBOutlet weak var patronymicLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var loginTextField: EVENTODORTextField!
    @IBOutlet weak var passwordTextField: EVENTODORTextField!
    @IBOutlet weak var nameTextField: EVENTODORTextField!
    @IBOutlet weak var surnameTextField: EVENTODORTextField!
    @IBOutlet weak var patronymicTextField: EVENTODORTextField!
    @IBOutlet weak var phoneTextField: EVENTODORTextField!
    @IBOutlet weak var emailTextField: EVENTODORTextField!
    @IBOutlet weak var countryTextField: EVENTODORTextField!
    @IBOutlet weak var cityTextField: EVENTODORTextField!
    @IBOutlet weak var addressTextField: EVENTODORTextField!
    @IBOutlet weak var organizerLabel: UILabel!
    @IBOutlet weak var termsOfUseLabel: UILabel!
    @IBOutlet weak var organizerButton: EVENTODORCheckbox!
    @IBOutlet weak var termsOfUseButton: EVENTODORCheckbox!
    @IBOutlet weak var registerButton: EVENTODORButton!
    
    // MARK: - Properties
    private var labels: [UILabel] {
        [loginLabel, passwordLabel, nameLabel, surnameLabel, patronymicLabel, phoneLabel, emailLabel, countryLabel, cityLabel, addressLabel]
    }
    
    // MARK: - Lifecycle method's
    override func viewDidLoad() {
        adjustableForKeyboard = true
        dismissKeyboardOnTap = true
        
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - Private method's
private
extension RegistrationViewController {
    
    func setupUI() {
        setupLabels()
        setupButton()
    }
    
    func setupLabels() {
        for label in labels {
            label.font = .systemFont(ofSize: 16)
            label.textColor = UIColor(red: 83/256, green: 92/256, blue: 94/256, alpha: 1.0)
        }
        loginLabel.text = "auth_login_title".localized()
        passwordLabel.text = "auth_password_title".localized()
        nameLabel.text = "register_surname".localized()
        surnameLabel.text = "register_name".localized()
        patronymicLabel.text = "register_patronymic".localized()
        phoneLabel.text = "register_phone".localized()
        emailLabel.text = "register_email".localized()
        countryLabel.text = "register_country".localized()
        cityLabel.text = "register_city".localized()
        addressLabel.text = "register_address".localized()
        
        organizerLabel.font = .systemFont(ofSize: 16)
        organizerLabel.textColor = .black
        termsOfUseLabel.font = .systemFont(ofSize: 16)
        termsOfUseLabel.textColor = .black
        organizerLabel.text = "register_organizer".localized()
        termsOfUseLabel.text = "register_terms_of_use".localized()
    }
    
    func setupButton() {
        setupCheckBox()
        registerButton.setTitle(with: "auth_register_button".localized())
        registerButton.onTap = { [weak self] in
            let categoryViewController = CategoryPickerViewController()
            self?.navigationController?.pushViewController(categoryViewController, animated: true)
        }
    }
    
    func setupCheckBox() {
        organizerButton.isEnabled = false
        termsOfUseButton.isEnabled = false
    }
}