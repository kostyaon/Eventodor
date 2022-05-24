//
//  EventsViewModel.swift
//  Eventodor
//
//  Created by Petrykevich, Kanstantsin on 16.12.21.
//

import Foundation

class EventsViewModel: BaseViewModel {
    
    // Properties
    var availableEvents: [Event] = []
    var myEvents: [Event] = []
    
    // Method's
    func getEvents() {
        myEvents = []
        enterRequest()
        EventodorInterface.loadFromServer(router: EventodorRouter.Event.allEvents) { [weak self] result in
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
                this.availableEvents = events
                this.getMyEvents()
            }
        }
    }
    
    
}

// MARK: - Private method's
private
extension EventsViewModel {
    
    func getMyEvents() {
        enterRequest()
        EventodorInterface.loadFromServer(router: EventodorRouter.Event.myEvents) { [weak self] result in
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
        EventodorInterface.loadFromServer(router: EventodorRouter.Event.eventById(id)) { [weak self] result in
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
                this.myEvents.append(event)
            }
        }
    }
}
