//
//  RegistrationViewModel.swift
//  Eventodor
//
//  Created by Petrykevich, Kanstantsin on 16.12.21.
//

import Foundation

class RegistrationViewModel: BaseViewModel {
    
    enum ErrorType: Error {
        
        case clientError
        case serverError
        case unknown
    }
    
    func login(username: String, password: String) {
        enterRequest()
        EventodorInterface.uploadToServer(router: EventodorRouter.login(username, password)) { [weak self] result in
            guard let this = self else { return }
            this.leaveRequest()
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let jsonResponse):
                guard let user = RegUser.decode(from: jsonResponse) else { return }
                if let token = user.key {
                    UserDefaults.standard.set(token, forKey: "token")
                }
                print("Success login \(user)")
            }
        }
    }
    
    func register(with user: User) {
        register(user: user)
        self.notifyWhenRequestsCompleted { [weak self] in
            guard let this = self else { return }
            print("Requests completed")
            this.updateUI?()
        }
    }
}

private
extension RegistrationViewModel {
    
    func showError(of error: RegistrationViewModel.ErrorType, message: String? = nil) {
        switch error {
        case .clientError:
            guard let message = message else {
                presentError?("error_client".localized())
                return
            }
            presentError?(message)
        case .serverError:
            presentError?("error_server".localized())
        case .unknown:
            presentError?("error_unknown".localized())
        }
    }
    
    func register(user: User) {
        enterRequest()
        EventodorInterface.uploadToServer(router: EventodorRouter.register(user.username ?? "", user.email ?? "", user.password ?? "")) { [weak self] result in
            guard let this = self else { return }
            this.leaveRequest()
            switch result {
            case .success(let jsonResponse):
                guard let responseUser = RegUser.decode(from: jsonResponse) else { return }
                if let username = responseUser.username?.first {
                    this.showError(of: .clientError, message: username)
                    return
                }
                
                if let email = responseUser.email?.first {
                    this.showError(of: .clientError, message: email)
                    return
                }
                
                if let password1 = responseUser.password1?.first {
                    this.showError(of: .clientError, message: password1)
                    return
                }
                
                if let token = responseUser.key {
                    UserDefaults.standard.set(token, forKey: "token")
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
        EventodorInterface.uploadToServer(router: EventodorRouter.registerUser(user)) { [weak self] result in
            guard let this = self else { return }
            this.leaveRequest()
            switch result {
            case .success(let jsonResponse):
                if let details = jsonResponse["detail"] as? String {
                    this.showError(of: .clientError, message: details)
                    return
                }
                if let user = User.decode(from: jsonResponse) {
                    print("Register user", user)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
