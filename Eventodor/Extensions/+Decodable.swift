//
//  +Decodable.swift
//  Eventodor
//
//  Created by Petrykevich, Kanstantsin on 20.02.22.
//

import Foundation

public
extension Decodable {
    
    static func decode(from any: Any) -> Self? {
        if let dictionary = any as? [String: Any] {
            guard let data = try? JSONSerialization.data(withJSONObject: dictionary, options: []) else { return nil }
            return decode(from: data)
        } else if let array = any as? [[String: Any]] {
            guard let data = try? JSONSerialization.data(withJSONObject: array, options: []) else { return nil }
            return decode(from: data)
        } else if let data = any as? Data {
            return try! JSONDecoder().decode(Self.self, from: data)
        } else {
            return nil
        }
    }
}
