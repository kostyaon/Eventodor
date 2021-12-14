//
//  User.swift
//  Eventodor
//
//  Created by Petrykevich, Kanstantsin on 15.12.21.
//

import Foundation

struct User: Decodable {
    
    var user_id: Int?
    var photo: Photo?
    var name: String?
    var surname: String?
    var patronymic: String?
    var phone: String?
    var email: String?
    var country: String?
    var city: String?
    var address: String?
    var bankAccount: String?
}

struct Photo: Decodable {
    
    var photo_id: Int?
    var url: String?
}
