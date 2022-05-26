//
//  CreateEventViewModel.swift
//  Eventodor
//
//  Created by Petrykevich, Kanstantsin on 25.05.22.
//

import Foundation

class CreateEventViewModel: BaseViewModel {
    
    // Properties
    
    // Method's
    func postEvent(event: Event?) {
        guard let event = event else {
            return
        }
        enterRequest()
        EventodorInterface.uploadToServer(router: EventodorRouter.EventRouter.postEvent(event)) { [weak self] result in
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
                guard let _ = Event.decode(from: jsonResponse) else { return }
                AppEnvironment.setCreateAward(bool: true)
                this.updateUI?()
            }
        }
    }
}
