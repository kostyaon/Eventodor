//
//  Event.swift
//  Eventodor
//
//  Created by Petrykevich, Kanstantsin on 15.12.21.
//

import Foundation

struct Event: Decodable {
    
    var event_id: Int?
    var photo: Photo?
    var coordinate: Coordinate?
    var category: Category?
    var address: String?
    var persons_amount: Int?
    var register_persons_amount: Int?
    var name: String?
    var descriptioin: String?
    var time: String?
    var price: Float?
    var rank: Float?
}

struct Coordinate: Decodable {
    
    var coordinate_id: Int?
    var longitude: String?
    var latitude: String?
    var height: String?
}
