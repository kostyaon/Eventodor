//
//  LoginViewController.swift
//  Eventodor
//
//  Created by Petrykevich, Kanstantsin on 13.12.21.
//

import UIKit

class LoginViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var loginButton: EVENTODORButton!
    @IBOutlet weak var registerButton: EVENTODORButton!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var loginTextField: EVENTODORTextField!
    @IBOutlet weak var passwordTextField: EVENTODORTextField!
    
    // MARK: - Properties
    
    // MARK: - Lifecycle method's
    override func viewDidLoad() {
        adjustableForKeyboard = true
        dismissKeyboardOnTap = true
        
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Helper method's
    
}

// MARK: - Private method's
private
extension LoginViewController {
    
    func setupUI() {
        setupLabels()
        setupButtons()
    }
    
    func setupLabels() {
        loginLabel.font = .systemFont(ofSize: 16)
        loginLabel.text = "auth_login_title".localized()
        loginLabel.textColor = UIColor(red: 83/256, green: 92/256, blue: 94/256, alpha: 1.0)
        passwordLabel.font = .systemFont(ofSize: 16)
        passwordLabel.text = "auth_password_title".localized()
        passwordLabel.textColor = UIColor(red: 83/256, green: 92/256, blue: 94/256, alpha: 1.0)
    }
    
    func setupButtons() {
        loginButton.setTitle(with: "auth_login_title".localized())
        loginButton.isEnabled = false
        registerButton.setTitle(with: "auth_register_button".localized())
        registerButton.isEnabled = true
        
        setupActions()
    }
    
    func setupActions() {
        loginButton.onTap = { [weak self] in
            print("Login button")
        }
        registerButton.onTap = { [weak self] in
            let registrationViewController = RegistrationViewController()
            self?.navigationController?.pushViewController(registrationViewController, animated: true)
        }
    }
}
