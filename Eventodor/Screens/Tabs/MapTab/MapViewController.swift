//
//  MapViewController.swift
//  Eventodor
//
//  Created by Petrykevich, Kanstantsin on 16.12.21.
//

import UIKit
import MapKit

class MapViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: - Lifecycle method's
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let initialLocation = CLLocation(latitude: 53.9006, longitude: 27.5590)
        mapView.centerToLocation(initialLocation)
        defineMappingRegion()
    }
}

// MARK: - Private method's
private
extension MapViewController {
    
    func defineMappingRegion() {
        let minskCenter = CLLocation(latitude: 53.9006, longitude: 27.5590)
        let region = MKCoordinateRegion(
            center: minskCenter.coordinate,
            latitudinalMeters: 20000,
            longitudinalMeters: 25000)
        mapView.setCameraBoundary(
            MKMapView.CameraBoundary(coordinateRegion: region),
            animated: true)
        
        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 50000)
        mapView.setCameraZoomRange(zoomRange, animated: true)
    }
}
