//
//  EventsViewModel.swift
//  Eventodor
//
//  Created by Petrykevich, Kanstantsin on 16.12.21.
//

import Foundation

class EventsViewModel {
    
    var availableEvents: [Event]?
    var myEvents: [Event]?
    
    func getEvents() {
        if let path = Bundle.main.path(forResource: "Coordinates", ofType: "json") {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) {
                let jsonDecoder = JSONDecoder()
                if let events = try? jsonDecoder.decode([Event].self, from: data) {
                    for event in events {
                        if AppEnvironment.categoryIndexes?.contains(event.category?.category_id ?? -1) ?? false {
                            availableEvents?.append(event)
                        } else {
                            if event.category?.name == "My events" {
                                myEvents?.append(event)
                            }
                        }
                    }
                }
            }
        }
    }
}
