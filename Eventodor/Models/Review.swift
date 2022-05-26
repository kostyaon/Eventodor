//
//  Review.swift
//  Eventodor
//
//  Created by Petrykevich, Kanstantsin on 15.12.21.
//

import Foundation

struct Review: Decodable {
    
    var review_id: Int?
    let event_id: Int?
    let user_id: Int?
    var description: String?
    var rank: Float?
    let reviewer: String?
    
    enum CodingKeys: String, CodingKey {
        
        // Event CodingKeys
        enum Event: CodingKey {
            
            case id
            case address
            case persons_amount
            case register_persons_amount
            case name
            case description
            case time
            case price
            case rank
            case photo
            case coordinate
            case category
            case organizer
        }
        
        // Organizer CodingKeys
        enum User: CodingKey {
            
            case id
            case name
            case surname
            case patronymic
            case phone
            case email
            case country
            case city
            case address
            case bankAccount
            case photo_id
        }
        
        case review_id = "id"
        case event_id = "event_id"
        case user_id
        case description
        case rank
    }
    
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        self.user_id = try? container?.decodeIfPresent(Int.self, forKey: .user_id)
        self.review_id = try? container?.decode(Int.self, forKey: .review_id)
        self.description = try? container?.decode(String.self, forKey: .description)
        let rankString = try? container?.decode(String.self, forKey: .rank)
        self.rank = (rankString as? NSString)?.floatValue
        let eventContainer = try? container?.nestedContainer(keyedBy: CodingKeys.Event.self, forKey: .event_id)
        self.event_id = try? eventContainer?.decode(Int.self, forKey: .id)
        let userContainer = try? container?.nestedContainer(keyedBy: CodingKeys.User.self, forKey: .user_id)
        self.reviewer = try? userContainer?.decode(String.self, forKey: .name)
    }
}
