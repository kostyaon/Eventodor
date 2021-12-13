//
//  LoginViewController.swift
//  Eventodor
//
//  Created by Petrykevich, Kanstantsin on 13.12.21.
//

import UIKit

class LoginViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
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
        
    }
}
