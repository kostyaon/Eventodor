//
//  EventRegCardViewModel.swift
//  Eventodor
//
//  Created by Petrykevich, Kanstantsin on 25.05.22.
//

import Foundation

class EventRegCardViewModel: BaseViewModel {
    
    // Properties
    var eventId: Int?
    var reviews: [Review] = []
    var rank: Float?
    var participants: [User] = []
    
    // Functions
    func getReview() {
        enterRequest()
        EventodorInterface.loadFromServer(router: EventodorRouter.Review.getReview) { [weak self] result in
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
                guard let jsonResponse = data as? [[String: Any]], let allReviews = [Review].decode(from: jsonResponse) else { return }
                this.reviews = allReviews.filter({ $0.event_id == this.eventId })
                this.calculateRank()
                this.getParticpants()
            }
        }
    }
    
    func checkRegistration() {
        enterRequest()
        EventodorInterface.loadFromServer(router: EventodorRouter.EventRouter.eventsByUserId(AppEnvironment.userId ?? 0)) { [weak self] result in
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
                guard let jsonResponse = data as? [[String: Any]], let eventUser = [EventUser].decode(from: jsonResponse) else { return }
                var isRegister: Bool = false
                for event in eventUser {
                    if event.event_id == (this.eventId ?? 0) {
                        this.showMessage(message: "already_register".localized())
                        isRegister = true
                        return
                    }
                }
                if !isRegister {
                    this.registerOnEvent()
                }
            }
        }
    }
}

// MARK: - Private
private
extension EventRegCardViewModel {
    
    func getParticpants() {
        participants = []
        enterRequest()
        EventodorInterface.loadFromServer(router: EventodorRouter.EventRouter.usersByEventId(eventId ?? 0)) { [weak self] result in
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
                guard let jsonResponse = data as? [[String: Any]], let eventUsers = [EventUser].decode(from: jsonResponse) else { return }
                let users = eventUsers.map({ return $0.user_id })
                users.forEach({ this.getUser(with: $0 ?? 0) })
            }
        }
    }
    
    func getUser(with id: Int) {
        enterRequest()
        EventodorInterface.loadFromServer(router: EventodorRouter.Users.userById(id)) { [weak self] result in
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
                guard let jsonResponse = data as? [String: Any], let user = User.decode(from: jsonResponse) else { return }
                this.participants.append(user)
            }
        }
        notifyWhenRequestsCompleted { [weak self] in
            guard let this = self else { return }
            this.updateUI?()
        }
    }
    
    func registerOnEvent() {
        enterRequest()
        EventodorInterface.uploadToServer(router: EventodorRouter.EventRouter.registerOnEvent(eventId ?? 0)) { [weak self] result in
            guard let this = self else { return }
            this.leaveRequest()
            
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let jsonResponse):
                if let detail = jsonResponse["detail"] as? String {
                    this.showMessage(message: detail)
                    return
                }
                
                if let errors = jsonResponse["non_field_errors"] as? [String] {
                    this.showMessage(message: errors.first ?? "")
                    return
                }
                
                this.showMessage(message: "succesfull_registration".localized())
            }
        }
    }
    
    func calculateRank() {
        let allRanks = reviews.map({ return $0.rank })
        let numberOfRanks = allRanks.count
        var sum: Float = 0.0
        allRanks.forEach({ sum += ($0 ?? 0.0) })
        if numberOfRanks <= 0 {
            rank = 0
        } else {
            rank = sum / Float(numberOfRanks)
        }
    }
}
