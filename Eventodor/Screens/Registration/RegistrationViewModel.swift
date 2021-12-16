//
//  RegistrationViewModel.swift
//  Eventodor
//
//  Created by Petrykevich, Kanstantsin on 16.12.21.
//

import Foundation

class RegistrationViewModel {
    
    func login(email: String, password: String) -> User? {
        if let path = Bundle.main.path(forResource: "Authentification", ofType: "json") {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) {
                let jsonDecoder = JSONDecoder()
                let users = try? jsonDecoder.decode([User].self, from: data)
                var returnUser: User?
                users?.forEach({
                    if $0.password == password {
                        returnUser = $0
                    }
                })
                return returnUser
            }
        }
        return nil
    }
    
    
    func register(user: User) -> User? {
        if let path = Bundle.main.path(forResource: "Authentification", ofType: "json") {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) {
                let jsonDecoder = JSONDecoder()
                let users = try? jsonDecoder.decode([User].self, from: data)
                var returnUser: User?
                users?.forEach({
                    if $0.password == user.password {
                        returnUser = $0
                    }
                })
                return returnUser
            }
        }
        return nil
    }
}
