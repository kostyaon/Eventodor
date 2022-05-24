//
//  CategoryPickerViewModel.swift
//  Eventodor
//
//  Created by Petrykevich, Kanstantsin on 16.12.21.
//

import Foundation

class CategoryPickerViewModel: BaseViewModel {
    
    // Properties
    var availableCategories: [CategoryEVENTODOR]?
    
    // Method's
    func getCategories() {
        enterRequest()
        EventodorInterface.loadFromServer(router: EventodorRouter.Category.getCategories) { [weak self] result in
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
                guard let jsonResponse = data as? [[String: Any]], let categories = [CategoryEVENTODOR].decode(from: jsonResponse) else { return }
                this.availableCategories = categories
            }
        }
        notifyWhenRequestsCompleted { [weak self] in
            guard let this = self else { return }
            this.updateUI?()
        }
    }
}
