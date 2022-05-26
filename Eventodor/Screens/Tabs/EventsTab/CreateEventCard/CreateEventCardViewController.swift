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
    private var event: Event?
    private var eventLocationAnnotation = MKPointAnnotation()
    private var isEventLocationSet = false
    private let viewModel = CreateEventViewModel(isRequestGroup: true)
    
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
    
    // MARK: - Override handler
    override func handleError() {
        viewModel.presentError = { [weak self] message in
            guard let this = self else { return }
            this.showError(title: "error_title".localized(), message: message)
        }
    }
    
    override func handleUpdateUI() {
        viewModel.updateUI = { [weak self] in
            guard let this = self else { return }
            this.showError(title: "error_success".localized(), message: "succesfully_created_event".localized())
        }
    }
}

// MARK: - Private method's
private
extension CreateEventCardViewController {
    
    // Properties
    var fields: [EVENTODORTextField] {
        [categoryTextField, personsAmountTextField,
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
    func uploadData() {
        prepareEvent()
        viewModel.postEvent(event: event)
    }
    
    func prepareEvent() {
        event = Event()
        event?.photo = nil
        let organizer = AppEnvironment.user
        event?.organizer = Organizer(id: nil, name: organizer?.name, surname: organizer?.surname, patronymic: organizer?.patronymic, phone: organizer?.phone, email: organizer?.email, country: organizer?.country, city: organizer?.city, address: organizer?.address, bankAccount: organizer?.bankAccount, photo_id: organizer?.photo_id, building_id: nil)
        
        var coordinate = CLLocationCoordinate2D()
        if eventLocationAnnotation.coordinate.latitude == 0.0 && eventLocationAnnotation.coordinate.longitude == 0.0 {
            coordinate = CLLocationCoordinate2D(latitude: myLocation?.coordinate.latitude ?? 0.0, longitude: myLocation?.coordinate.longitude ?? 0.0)
        } else {
            coordinate = eventLocationAnnotation.coordinate
        }
        
        event?.coordinate = CoordinateEVENTODOR(coordinate_id: nil, longitude: "\(coordinate.latitude)", latitude: "\(coordinate.longitude)", height: nil)
        event?.category = CategoryEVENTODOR(category_id: nil, name: categoryTextField.text)
        event?.address = organizer?.address
        event?.persons_amount = (personsAmountTextField.text as? NSString)?.integerValue
        event?.register_persons_amount = 0
        event?.name = nameTextField.text
        event?.description = descriptionTextField.text
        event?.time = "\(datePicker.date)"
        event?.price = priceTextField.text
        event?.rank = "3.8"
        event?.distance = nil
    }
    
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
        createButton.setTitle(with: "create_event_button".localized())
        createButton.onTap = { [weak self] in
            guard let this = self else { return }
            if !this.checkFields() {
                this.showError(title: "error_title".localized(), message: "input_field".localized())
            } else {
                this.uploadData()
                print(this.eventLocationAnnotation.coordinate)
            }
        }
        titleLabel.text = "create_event_title".localized()
    }
}
