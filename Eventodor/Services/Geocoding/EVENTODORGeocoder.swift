//
//  EVENTODORGeocoder.swift
//  Eventodor
//
//  Created by Petrykevich, Kanstantsin on 25.05.22.
//

import Foundation
import CoreLocation

class EVENTODORGeocoder {
    
    // MARK: - Properties
    private static let geocoder = CLGeocoder()
    
    // MARK: - Method's
    static func geocode(from location: CLLocation) {
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                print("reverse geodcode fail: \(error.localizedDescription)")
            }
            
            guard var pm = placemarks else { return }
            pm = pm as [CLPlacemark]
            if pm.count > 0 {
                let pm = placemarks![0]
                var addressString : String = ""
                if pm.subLocality != nil {
                    addressString = addressString + pm.subLocality! + ", "
                }
                if pm.thoroughfare != nil {
                    addressString = addressString + pm.thoroughfare! + ", "
                }
                if pm.locality != nil {
                    addressString = addressString + pm.locality! + ", "
                }
                if pm.country != nil {
                    addressString = addressString + pm.country! + ", "
                }
                if pm.postalCode != nil {
                    addressString = addressString + pm.postalCode! + " "
                }
                print("GEOCODED ADDRESS", addressString)
            }
        }
    }
}
