//
//  RegistrationViewModel.swift
//  Eventodor
//
//  Created by Petrykevich, Kanstantsin on 16.12.21.
//

import Foundation

class AuthenticationViewModel: BaseViewModel {
    
    // Method's
    func login(username: String, password: String) {
        enterRequest()
        EventodorInterface.uploadToServer(router: EventodorRouter.Auth.login(username, password)) { [weak self] result in
            guard let this = self else { return }
            this.leaveRequest()
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let jsonResponse):
                if let detail = jsonResponse["detail"] as? String {
                    this.showMessage(message: detail)
                    return
                }
                
                if let errors = jsonResponse["non_field_errors"] as? [String] {
                    this.showMessage(message: errors.first ?? "")
                    return
                }
                
                guard let user = RegUser.decode(from: jsonResponse) else { return }
                if let token = user.key {
                    AppEnvironment.setToken(with: token)
                    this.filterUser(username: username)
                }
            }
        }
    }
    
    func register(with user: User) {
        register(user: user)
    }
}

// MARK: - Private method's
private
extension AuthenticationViewModel {
    
    func register(user: User) {
        enterRequest()
        EventodorInterface.uploadToServer(router: EventodorRouter.Auth.register(user.myusername ?? "", user.email ?? "", user.password ?? "")) { [weak self] result in
            guard let this = self else { return }
            this.leaveRequest()
            switch result {
            case .success(let jsonResponse):
                guard let responseUser = RegUser.decode(from: jsonResponse) else { return }
                if let username = responseUser.username?.first {
                    this.showMessage(message: username)
                    return
                }
                
                if let email = responseUser.email?.first {
                    this.showMessage(message: email)
                    return
                }
                
                if let password1 = responseUser.password1?.first {
                    this.showMessage(message: password1)
                    return
                }
                
                if let token = responseUser.key {
                    AppEnvironment.setToken(with: token)
                }
                this.registerUser(with: user)
                print("Register auth", responseUser)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func registerUser(with user: User) {
        enterRequest()
        EventodorInterface.uploadToServer(router: EventodorRouter.Auth.registerUser(user)) { [weak self] result in
            guard let this = self else { return }
            this.leaveRequest()
            switch result {
            case .success(let jsonResponse):
                if let details = jsonResponse["detail"] as? String {
                    this.showMessage(message: details)
                    return
                }
                if let user = User.decode(from: jsonResponse) {
                    print("Register user", user)
                    AppEnvironment.user = user
                    this.updateUI?()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func filterUser(username: String) {
        enterRequest()
        EventodorInterface.loadFromServer(router: EventodorRouter.Users.getUsers) { [weak self] result in
            guard let this = self else { return }
            this.leaveRequest()
            
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let data):
                if let jsonResponse = data as? [String: Any], let detail = jsonResponse["detail"] as? String {
                    this.showMessage(message: detail)
                    return
                }
                guard let jsonResponse = data as? [[String: Any]], let users = [User].decode(from: jsonResponse) else { return }
                let myUser = users.filter({ $0.myusername == username })
                AppEnvironment.user = myUser.first
            }
        }
        notifyWhenRequestsCompleted { [weak self] in
            guard let this = self else { return }
            this.updateUI?()
        }
    }
}
