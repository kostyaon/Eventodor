//
//  MapViewController.swift
//  Eventodor
//
//  Created by Petrykevich, Kanstantsin on 16.12.21.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: BaseMapViewController {
    
    // MARK: - Actions
    @IBAction func onGetLocation(_ sender: UIButton) {
        getCurrentLocation()
    }
    
    // MARK: - Properties
    private var selectedEvent: Event?
    private lazy var disclosureButton: UIButton = {
        let button = UIButton(type: .detailDisclosure)
        button.addTarget(self, action: #selector(onEventPin), for: .touchUpInside)
        return button
    }()
    private let viewModel = EventsViewModel(isRequestGroup: true)
    private var availableEvents: [Event] = []
    private var isCurrentLocationEnabled = false
    
    // MARK: - Lifecycle method's
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureMap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        isCurrentLocationEnabled = false
        getCurrentLocation()
    }
    
    deinit {
        locationManager.stopUpdatingLocation()
    }
    
    // MARK: - Override handlers
    override func handleError() {
        viewModel.presentError = { [weak self] message in
            guard let this = self else { return }
            this.showError(title: "error_title".localized(), message: message)
        }
    }
    
    override func handleUpdateUI() {
        viewModel.updateUI = { [weak self] in
            guard let this = self else { return }
            this.availableEvents = this.viewModel.availableEvents
            this.addAnotation()
            this.mapView.reloadInputViews()
        }
    }
}

// MARK: - Private method's
private
extension MapViewController {
    
    @objc func onEventPin() {
        print("Select event - \(selectedEvent?.name ?? "NOPE")")
        let registerViewController = EventRegCardViewController()
        registerViewController.event = selectedEvent
        self.present(registerViewController, animated: true, completion: nil)
    }
    
    func configureMap() {
        mapView.delegate = self
        locationManager.delegate = self
    }
    
    func loadData() {
        viewModel.getEvents()
    }
    
    func addAnotation() {
        for event in availableEvents {
            let annotation = EventMap(event: event, title: event.name,
                                      locationName: "Price: \(event.price ?? "")  Date: \(event.time ?? "")",
                                      coordinate: CLLocationCoordinate2D(latitude: (event.coordinate?.longitude as? NSString)?.doubleValue ?? 0.0, longitude: (event.coordinate?.latitude as? NSString)?.doubleValue ?? 0.0))
            mapView.addAnnotation(annotation)
        }
    }
}

// MARK: - MKMapView delegate method's
extension MapViewController {
    
    override func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.title == "your_location".localized() {
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
extension MapViewController {
    
    override func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation:CLLocation = locations[0] as CLLocation
        if !isCurrentLocationEnabled {
            isCurrentLocationEnabled = true
            viewModel.currentLocation = currentLocation
        }
        
      
        let center = CLLocationCoordinate2D(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
        
        // Indicate user's location
        let myLocation = MKPointAnnotation()
        myLocation.coordinate = CLLocationCoordinate2DMake(currentLocation.coordinate.latitude, currentLocation.coordinate.longitude)
        myLocation.title = "your_location".localized()
        mapView.addAnnotation(myLocation)
    }
}
