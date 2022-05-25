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
            }
        }
        notifyWhenRequestsCompleted { [weak self] in
            guard let this = self else { return }
            this.updateUI?()
        }
    }
}

// MARK: - Private
private
extension EventRegCardViewModel {
    
    func calculateRank() {
        let allRanks = reviews.map({ return $0.rank })
        let numberOfRanks = allRanks.count
        var sum: Float = 0.0
        allRanks.forEach({ sum += ($0 ?? 0.0) })
        rank = sum / Float(numberOfRanks)
    }
}
