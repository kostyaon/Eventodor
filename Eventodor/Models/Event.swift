//
//  Event.swift
//  Eventodor
//
//  Created by Petrykevich, Kanstantsin on 15.12.21.
//

import Foundation

struct Event: Decodable {
    
    var id: Int?
    var photo: Photo?
    var organizer: Organizer?
    var coordinate: CoordinateEVENTODOR?
    var category: CategoryEVENTODOR?
    var address: String?
    var persons_amount: Int?
    var register_persons_amount: Int?
    var name: String?
    var description: String?
    var time: String?
    var price: String?
    var rank: String?
    var distance: Double?
}

struct CoordinateEVENTODOR: Decodable {
    
    var coordinate_id: Int?
    var longitude: String?
    var latitude: String?
    let height: String?
}

struct CategoryEVENTODOR: Decodable {
    
    var category_id: Int?
    var name: String?
}

struct EventUser: Decodable {
    
    let user_id: Int?
    let event_id: Int?
}


