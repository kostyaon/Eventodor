//
//  Organizer.swift
//  Eventodor
//
//  Created by Petrykevich, Kanstantsin on 24.05.22.
//

import Foundation

struct Organizer: Decodable {
    
    let id: Int?
    let name: String?
    let surname: String?
    let patronymic: String?
    let phone: String?
    let email: String?
    let country: String?
    let city: String?
    let address: String?
    let bankAccount: String?
    let photo_id: Int?
    let building_id: Int?
}
