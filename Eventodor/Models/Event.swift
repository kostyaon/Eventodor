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
    var organizer: String?
    var coordinate: CoordinateEVENTODOR?
    var category: CategoryEVENTODOR?
    var address: String?
    var persons_amount: Int?
    var register_persons_amount: Int?
    var name: String?
    var description: String?
    var time: String?
    var price: Float?
    var rank: Float?
    var distance: Float?
}

struct CoordinateEVENTODOR: Decodable {
    
    var coordinate_id: Int?
    var longitude: Double?
    var latitude: Double?
}

struct CategoryEVENTODOR: Decodable {
    
    var category_id: Int?
    var name: String?
}

