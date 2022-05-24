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
    private var viewModel = AuthenticationViewModel(isRequestGroup: true)
    
    // MARK: - Lifecycle method's
    override func viewDidLoad() {
        adjustableForKeyboard = true
        dismissKeyboardOnTap = true
        
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Override handler
    override func handleError() {
        viewModel.presentError = { [weak self] message in
            guard let this = self else { return }
            this.showError(message: message)
        }
    }
    
    override func handleUpdateUI() {
        viewModel.updateUI = { [weak self] in
            guard let this = self else { return }
            this.navigationController?.pushViewController(CategoryPickerViewController(), animated: true)
        }
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
        loginLabel.textColor = .labelColor
        passwordLabel.font = .systemFont(ofSize: 16)
        passwordLabel.text = "auth_password_title".localized()
        passwordLabel.textColor = .labelColor
    }
    
    func setupButtons() {
        loginButton.setTitle(with: "auth_login_title".localized())
        loginButton.isEnabled = true
        registerButton.setTitle(with: "auth_register_button".localized())
        registerButton.isEnabled = true
        
        setupActions()
    }
    
    func setupActions() {
        loginButton.onTap = { [weak self] in
            guard let this = self else { return }
            if this.checkRequiredFields() {
                this.viewModel.login(username: this.loginTextField.text ?? "", password: this.passwordTextField.text ?? "")
            }
        }
        registerButton.onTap = { [weak self] in
            guard let this = self else { return }
            let registrationViewController = RegistrationViewController()
            this.navigationController?.pushViewController(registrationViewController, animated: true)
        }
    }
    
    func checkRequiredFields() -> Bool {
        if  checkField(label: loginLabel, field: loginTextField) &&
            checkField(label: passwordLabel, field: passwordTextField) {
            return true
        } else {
            return false
        }
    }
    
    func checkField(label: UILabel, field: EVENTODORTextField) -> Bool {
        if field.text?.isEmpty ?? true {
            label.textColor = .red
            return false
        } else {
            label.textColor = .labelColor
            return true
        }
    }
}
