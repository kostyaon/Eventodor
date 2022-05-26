//
//  ReviewViewModel.swift
//  Eventodor
//
//  Created by Petrykevich, Kanstantsin on 26.05.22.
//

import Foundation

class ReviewViewModel: BaseViewModel {
    
    // Properties
    
    // Method's
    func sendReview(eventId: Int, description: String, rank: Float) {
        enterRequest()
        EventodorInterface.uploadToServer(router: EventodorRouter.Review.sendReview(eventId, AppEnvironment.userId ?? 1, description, rank)) { [weak self] result in
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
                
                if let descField = jsonResponse["description"] as? [String] {
                    this.showMessage(message: descField.first ?? "")
                    return
                }
                guard let _ = Review.decode(from: jsonResponse) else { return }
            }
        }
        notifyWhenRequestsCompleted { [weak self] in
            guard let this = self else { return }
            this.updateUI?()
        }
    }
}
