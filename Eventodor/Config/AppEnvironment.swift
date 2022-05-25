//
//  AppEnvironment.swift
//  Eventodor
//
//  Created by Petrykevich, Kanstantsin on 16.12.21.
//

import Foundation

struct AppEnvironment {
    
    static var userId: Int? = 1
    static var user: User? = User(id: 1, photo_id: 1, name: "kostya", password: nil, surname: "ceo petrik", patronymic: "iOS'ovich", phone: "iPhone", email: "soci@soci.com", country: "Belarus", city: "Minsk", address: "My Address", bankAccount: "HugeAccount", username: "kostya")
    static var categoryIndexes: [Int]?
    static var isRegister: Bool? = false
    static var isRegisterOnEvent: Bool? = false
    static var myEvent: Bool? = false
}
