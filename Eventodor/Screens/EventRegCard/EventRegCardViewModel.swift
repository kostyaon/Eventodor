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
            }
        }
        notifyWhenRequestsCompleted { [weak self] in
            guard let this = self else { return }
            this.updateUI?()
        }
    }
}
