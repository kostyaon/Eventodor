//
//  CreateEventCardViewController.swift
//  Eventodor
//
//  Created by Petrykevich, Kanstantsin on 14.12.21.
//

import UIKit
import MapKit
import CoreLocation

class CreateEventCardViewController: BaseMapViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var organizaationTextField: EVENTODORTextField!
    @IBOutlet weak var categoryTextField: EVENTODORTextField!
    @IBOutlet weak var personsAmountTextField: EVENTODORTextField!
    @IBOutlet weak var nameTextField: EVENTODORTextField!
    @IBOutlet weak var descriptionTextField: EVENTODORTextField!
    @IBOutlet weak var priceTextField: EVENTODORTextField!
    @IBOutlet weak var createButton: EVENTODORButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    // MARK: - Action
    @IBAction func onGetLocation() {
        getCurrentLocation()
    }
    
    // MARK: - Properties
    private var eventLocationAnnotation = MKPointAnnotation()
    private var isEventLocationSet = false
    
    // MARK: - Lifecycle method's
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dismissKeyboardOnTap = true
        setupUI()
        configureMap()
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
    
    // Properties
    var fields: [EVENTODORTextField] {
        [categoryTextField, organizaationTextField, personsAmountTextField,
         nameTextField, descriptionTextField, priceTextField
        ]
    }
    
    // @objc method's
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
    
    // Method's
    func checkFields() -> Bool {
        for field in fields {
            if field.text?.isEmpty == true {
                return false
            }
        }
        return true
    }
    
    func setupUI() {
        setupText()
        setupGestures()
    }
    
    func configureMap() {
        mapView.delegate = self
        locationManager.delegate = self
    }
    
    func setupGestures() {
        let longTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(onLongPressure))
        mapView.addGestureRecognizer(longTapGesture)
    }
    
    func setupText() {
        createButton.setTitle(with: "create_event_title".localized())
        createButton.onTap = { [weak self] in
            guard let this = self else { return }
            if !this.checkFields() {
                this.showError(title: "error_title".localized(), message: "input_field".localized())
            } else {
                print(this.eventLocationAnnotation.coordinate)
            }
        }
        titleLabel.text = "create_event_button".localized()
    }
    
    func checkFields() {
        
    }
}
