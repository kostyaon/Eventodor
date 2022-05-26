//
//  ProfileViewController.swift
//  Eventodor
//
//  Created by Petrykevich, Kanstantsin on 15.12.21.
//

import UIKit

class ProfileViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameSurnameLabel: UILabel!
    @IBOutlet weak var patronymicLabel: UILabel!
    @IBOutlet weak var bankAccountLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var logoutButton: EVENTODORButton!
    
    // MARK: - Lifecycle method's
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
}

// MARK: - Private method's
private
extension ProfileViewController {
    
    func setupUI() {
        setupUserInfo()
        logoutButton.setTitle(with: "Выйти")
        logoutButton.onTap = { [weak self] in
            guard let this = self else { return }
            let sceneDelegate = this.view.window?.windowScene?.delegate as! SceneDelegate
            sceneDelegate.window?.rootViewController = UINavigationController(rootViewController: LoginViewController())
            
            // Delete token
            AppEnvironment.removeToken()
            AppEnvironment.removeUserId()
            AppEnvironment.removeAwards()
            
            // Animate
            let options: UIView.AnimationOptions = .transitionCrossDissolve
            let duration: TimeInterval = 0.3
            UIView.transition(with: sceneDelegate.window ?? UIWindow(), duration: duration, options: options, animations: {})
        }
    }
    
    func setupUserInfo() {
        let user = AppEnvironment.user
        nameSurnameLabel.text = "\(user?.name ?? "Пусто") \(user?.surname ?? "Пусто")"
        patronymicLabel.text = user?.patronymic ?? "Пусто"
        emailLabel.text = "Почта: \(user?.email ?? "Пусто")"
        bankAccountLabel.text = "Номер банковского счета: \n\(user?.bankAccount ?? "Пусто")"
    }
}
