//
//  AppEnvironment.swift
//  Eventodor
//
//  Created by Petrykevich, Kanstantsin on 16.12.21.
//

import Foundation

struct AppEnvironment {
    
    // Properties
    static var userId: Int? {
        return user?.id
    }
    static var user: User?
    static var categoryIndexes: [Int] = []
    static var isRegister: Bool? = false
    static var isRegisterOnEvent: Bool? = false
    static var myEvent: Bool? = false
    
    // Method's
    static func setToken(with token: String) {
        UserDefaults.standard.set(token, forKey: "token")
    }
    
    static func removeToken() {
        UserDefaults.standard.removeObject(forKey: "token")
        UserDefaults.standard.removeObject(forKey: "token")
    }
    
    static func setUserId(with id: Int?) {
        guard let id = id else { return }
        UserDefaults.standard.set(id, forKey: "user_id")
    }
    
    static func removeUserId() {
        UserDefaults.standard.removeObject(forKey: "user_id")
    }
}
