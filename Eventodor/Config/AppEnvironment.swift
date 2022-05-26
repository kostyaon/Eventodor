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
    static var myEvent: Bool? = false
    static var isCreateAward: Bool? {
        UserDefaults.standard.bool(forKey: "award_create")
    }
    
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
    
    static func setCreateAward(bool: Bool) {
        UserDefaults.standard.set(bool, forKey: "award_create")
    }
    
    
    static func removeAwards() {
        UserDefaults.standard.removeObject(forKey: "award_create")
    }
}
