//
//  MapViewController.swift
//  Eventodor
//
//  Created by Petrykevich, Kanstantsin on 16.12.21.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: - Actions
    @IBAction func onGetLocation(_ sender: UIButton) {
        getCurrentLocation()
    }
    
    // MARK: - Properties
    private var locationManager: CLLocationManager!
    private var selectedEvent: Event?
    private lazy var disclosureButton: UIButton = {
        let button = UIButton(type: .detailDisclosure)
        button.addTarget(self, action: #selector(onEventPin), for: .touchUpInside)
        return button
    }()
    private let viewModel = EventsViewModel()
    private var availableEvents: [Event] = []
    
    // MARK: - Lifecycle method's
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        setupMapView()
        defineMappingRegion()
        addAnotation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        getCurrentLocation()
    }
    
    deinit {
        locationManager.stopUpdatingLocation()
    }
}

// MARK: - Private method's
private
extension MapViewController {
    
    @objc func onEventPin() {
        print("Select event - \(selectedEvent?.name ?? "NOPE")")
    }
    
    func loadData() {
        viewModel.getEvents()
        availableEvents = viewModel.availableEvents
        mapView.reloadInputViews()
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
    
    func addAnotation() {
        for event in availableEvents {
            let annotation = EventMap(event: event, title: event.name,
                                      locationName: "Price: \(event.price ?? 0.0)  Date: \(event.time ?? "")",
                                      coordinate: CLLocationCoordinate2D(latitude: event.coordinate?.longitude ?? 0.0, longitude: event.coordinate?.latitude ?? 0.0))
            mapView.addAnnotation(annotation)
        }
    }
    
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

// MARK: - MKMapView delegate method's
extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.title == "Your location" {
            let view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "MyAnnotation")
            view.markerTintColor = .green
            return view
        }
        guard let annotation = annotation as? EventMap else { return nil }
        let identifier = "event"
        var view: MKMarkerAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            selectedEvent = annotation.event
            view.rightCalloutAccessoryView = disclosureButton
        }
        return view
    }
}

// MARK: - CLLocationManagerDelegate method's
extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation:CLLocation = locations[0] as CLLocation
        print(currentLocation)
        let center = CLLocationCoordinate2D(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
        
        // Indicate user's location
        let myLocation = MKPointAnnotation()
        myLocation.coordinate = CLLocationCoordinate2DMake(currentLocation.coordinate.latitude, currentLocation.coordinate.longitude)
        myLocation.title = "Your location"
        mapView.addAnnotation(myLocation)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error - locationManager: \(error.localizedDescription)")
    }
}
