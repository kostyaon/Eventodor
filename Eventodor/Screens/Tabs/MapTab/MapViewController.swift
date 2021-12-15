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
    
    // MARK: - Properties
    private var selectedEvent: Event?
    private lazy var disclosureButton: UIButton = {
        let button = UIButton(type: .detailDisclosure)
        button.addTarget(self, action: #selector(onEventPin), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle method's
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMapView()
        defineMappingRegion()
        addAnotation()
    }
}

// MARK: - Private method's
private
extension MapViewController {
    
    @objc func onEventPin() {
        print("Select event - \(selectedEvent?.name ?? "NOPE")")
    }
    
    func setupMapView() {
        mapView.delegate = self
        let initialLocation = CLLocation(latitude: 53.9006, longitude: 27.5590)
        mapView.centerToLocation(initialLocation)
    }
    
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
    
    func addAnotation() {
        let galleryMinsk = EventMap(title: "Event On Gallery",
                                    locationName: "Gallery Minsk",
                                    coordinate: CLLocationCoordinate2D(latitude: 53.90896686425321, longitude: 27.54919321698397))
        mapView.addAnnotation(galleryMinsk)
    }
}

// MARK: - MKMapView delegate method's
extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
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
          view.rightCalloutAccessoryView = disclosureButton
        }
        return view
      }
}
