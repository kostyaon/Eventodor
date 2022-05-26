//
//  BaseMapViewController.swift
//  Eventodor
//
//  Created by Petrykevich, Kanstantsin on 25.05.22.
//

import Foundation
import MapKit
import CoreLocation

class BaseMapViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: - Properties
    var myLocation: CLLocation?
    var locationManager = CLLocationManager()
    private var eventLocationAnnotation = MKPointAnnotation()
    private var isEventLocationSet = false
    
    // MARK: - Lifecycle method's
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    // MARK: - Helper method's
    func getCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
}

// MARK: - Private method's
private
extension BaseMapViewController {
    
    func configureMap() {
        setupMapView()
        defineMappingRegion()
    }
    
    func setupMapView() {
        mapView.delegate = self
        let initialLocation = CLLocation(latitude: 53.91974976740907, longitude: 27.593096852856355)
        mapView.centerToLocation(initialLocation)
    }
    
    func defineMappingRegion() {
        let minskCenter = CLLocation(latitude: 53.91974976740907, longitude: 27.593096852856355)
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

// MARK: - CLLocationManagerDelegate method's
extension BaseMapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation: CLLocation = locations[0] as CLLocation
        myLocation = currentLocation
        let center = CLLocationCoordinate2D(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
        
        // Indicate user's location
        let myLocation = MKPointAnnotation()
        myLocation.coordinate = CLLocationCoordinate2DMake(currentLocation.coordinate.latitude, currentLocation.coordinate.longitude)
        myLocation.title = "your_location".localized()
        mapView.addAnnotation(myLocation)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        showError(title: "error_title".localized(), message: "location_error".localized())
        print("Error - locationManager: \(error.localizedDescription)")
    }
}

// MARK: - MKMapViewDelegate method's
extension BaseMapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.title == "your_location".localized() {
            let view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "MyAnnotation")
            view.markerTintColor = .green
            view.isDraggable = false
            return view
        } else {
            let eventMark = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "MyAnnotation")
            eventMark.markerTintColor = .red
            eventMark.isDraggable = true
            return eventMark
        }
    }
}
