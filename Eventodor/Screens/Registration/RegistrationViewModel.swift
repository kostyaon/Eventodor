//
//  RegistrationViewModel.swift
//  Eventodor
//
//  Created by Petrykevich, Kanstantsin on 16.12.21.
//

import Foundation
import AVFoundation

class RegistrationViewModel {
    
    func login(username: String, password: String) {
        EventodorInterface.uploadToServer(type: RegUser.self, router: EventodorRouter.login(username, password)) { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let user):
                if let token = user.key {
                    UserDefaults.standard.set(token, forKey: "token")
                }
                print("Success login \(user)")
            }
        }
    }
    
    
    func register(user: User) {
        EventodorInterface.uploadToServer(type: RegUser.self, router: EventodorRouter.register(user.surname ?? "", user.email ?? "", user.password ?? "")) { result in
            switch result {
            case .success(let user):
                if let token = user.key {
                    UserDefaults.standard.set(token, forKey: "token")
                }
                print(user)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
