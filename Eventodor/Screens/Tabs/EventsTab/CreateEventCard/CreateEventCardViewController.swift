//
//  CreateEventCardViewController.swift
//  Eventodor
//
//  Created by Petrykevich, Kanstantsin on 14.12.21.
//

import UIKit
import MapKit
import CoreLocation

class CreateEventCardViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var organizaationTextField: EVENTODORTextField!
    @IBOutlet weak var categoryTextField: EVENTODORTextField!
    @IBOutlet weak var personsAmountTextField: EVENTODORTextField!
    @IBOutlet weak var nameTextField: EVENTODORTextField!
    @IBOutlet weak var descriptionTextField: EVENTODORTextField!
    @IBOutlet weak var dateTextField: EVENTODORTextField!
    @IBOutlet weak var priceTextField: EVENTODORTextField!
    @IBOutlet weak var createButton: EVENTODORButton!
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: - Properties
    private var locationManager = CLLocationManager()
    private var eventLocationAnnotation = MKPointAnnotation()
    private var isEventLocationSet = false
    
    // MARK: - Lifecycle method's
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dismissKeyboardOnTap = true
        setupUI()
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
extension CreateEventCardViewController {
    
    @objc func onBgView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func onLongPressure(sender: UILongPressGestureRecognizer) {
        if !isEventLocationSet {
            isEventLocationSet = true
            if sender.state != UIGestureRecognizer.State.began { return }
            let touchLocation = sender.location(in: mapView)
            let locationCoordinate = mapView.convert(touchLocation, toCoordinateFrom: mapView)
            print("Tapped at lat: \(locationCoordinate.latitude) long: \(locationCoordinate.longitude)")
            
            eventLocationAnnotation = MKPointAnnotation(__coordinate: locationCoordinate)
            eventLocationAnnotation.title = "event_location".localized()
            mapView.addAnnotation(eventLocationAnnotation)
        }
    }
    
    func setupUI() {
        setupCardView()
        setupAction()
        setupText()
        setupMapView()
        defineMappingRegion()
    }
    
    func setupText() {
        createButton.setTitle(with: "create_event_title".localized())
        createButton.onTap = { [weak self] in
            print(self?.eventLocationAnnotation.coordinate)
        }
        titleLabel.text = "create_event_button".localized()
    }
    
    func setupAction() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onBgView))
        bgView.addGestureRecognizer(tapGesture)
    }
    
    func setupCardView() {
        cardView.layer.cornerRadius = 24
        cardView.layer.shadowOpacity = 0.5
        cardView.layer.shadowOffset = CGSize(width: 0.0, height: 10.0)
        cardView.layer.shadowRadius = 15
    }
    
    func setupMapView() {
        mapView.delegate = self
        let initialLocation = CLLocation(latitude: 53.91974976740907, longitude: 27.593096852856355)
        mapView.centerToLocation(initialLocation)
        
        let longTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(onLongPressure))
        mapView.addGestureRecognizer(longTapGesture)
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

// MARK: - MKMapViewDelegate method's
extension CreateEventCardViewController: MKMapViewDelegate {
    
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


// MARK: - CLLocationManagerDelegate method's
extension CreateEventCardViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation:CLLocation = locations[0] as CLLocation
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
