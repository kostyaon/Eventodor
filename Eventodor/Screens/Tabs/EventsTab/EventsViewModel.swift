//
//  EventsViewModel.swift
//  Eventodor
//
//  Created by Petrykevich, Kanstantsin on 16.12.21.
//

import Foundation
import CoreLocation

class EventsViewModel: BaseViewModel {
    
    // Event enum
    enum EventType {
        
        case events
        case myEvents
    }
    
    // Properties
    var availableEvents: [Event] = []
    var myEvents: [Event] = []
    var currentLocation: CLLocation?
    
    // Method's
    func getEvents() {
        availableEvents = []
        myEvents = []
        enterRequest()
        EventodorInterface.loadFromServer(router: EventodorRouter.EventRouter.allEvents) { [weak self] result in
            guard let this = self else { return }
            this.leaveRequest()
            
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let data):
                if let jsonResponse = data as? [String: Any], let detail = jsonResponse["detail"] as? String {
                    this.showMessage(message: detail)
                    return
                }
                guard let jsonResponse = data as? [[String: Any]], let events = [Event].decode(from: jsonResponse) else { return }
                events.forEach({ this.calculateDistance(for: $0, type: .events) })
                this.getMyEvents()
            }
        }
    }
}

// MARK: - Private method's
private
extension EventsViewModel {
    
    func calculateDistance(for event: Event, type: EventType) {
        let eventLocation = CLLocation(latitude: (event.coordinate?.longitude as? NSString)?.doubleValue ?? 0.0, longitude: (event.coordinate?.latitude as? NSString)?.doubleValue ?? 0.0)
        var distance = 0.0
        if let currentLocation = currentLocation {
            distance = currentLocation.distance(from: eventLocation)
            print("Distance to \(event.name ?? "") is \(distance) meters")
        }
        var appendedEvent = event
        appendedEvent.distance = distance
        if type == .events {
            availableEvents.append(appendedEvent)
        } else {
            myEvents.append(appendedEvent)
        }
    }
    
    func getMyEvents() {
        enterRequest()
        EventodorInterface.loadFromServer(router: EventodorRouter.EventRouter.myEvents) { [weak self] result in
            guard let this = self else { return }
            this.leaveRequest()
            
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let data):
                if let jsonResponse = data as? [String: Any], let detail = jsonResponse["detail"] as? String {
                    this.showMessage(message: detail)
                    return
                }
                guard let jsonResponse = data as? [[String: Any]], let allEvents = [EventUser].decode(from: jsonResponse) else { return }
                let myEventsArray = allEvents.filter({ $0.user_id == AppEnvironment.userId })
                myEventsArray.forEach {
                    this.getEvent(byId: $0.event_id ?? 1)
                }
                this.notifyWhenRequestsCompleted { [weak self] in
                    guard let this = self else { return }
                    this.updateUI?()
                }
            }
        }
    }
    
    func getEvent(byId id: Int) {
        enterRequest()
        EventodorInterface.loadFromServer(router: EventodorRouter.EventRouter.eventById(id)) { [weak self] result in
            guard let this = self else { return }
            this.leaveRequest()
            
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let data):
                if let jsonResponse = data as? [String: Any], let detail = jsonResponse["detail"] as? String {
                    this.showMessage(message: detail)
                    return
                }
                guard let jsonResponse = data as? [String: Any], let event = Event.decode(from: jsonResponse) else { return }
                this.calculateDistance(for: event, type: .myEvents)
            }
        }
    }
}
