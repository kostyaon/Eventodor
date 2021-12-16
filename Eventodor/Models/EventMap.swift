//
//  EventMap.swift
//  Eventodor
//
//  Created by Petrykevich, Kanstantsin on 16.12.21.
//

import MapKit

class EventMap: NSObject, MKAnnotation {
    
    var event: Event?
    var title: String?
    var locationName: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title: String?, locationName: String?, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
}
