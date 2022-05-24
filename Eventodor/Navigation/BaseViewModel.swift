//
//  BaseViewModel.swift
//  Eventodor
//
//  Created by Petrykevich, Kanstantsin on 24.05.22.
//

import Foundation

public typealias Closure = (() -> ())

class BaseViewModel: NSObject {
    
    // Types of erroe
    enum ErrorType: Error {
        
        case clientError
        case serverError
        case unknown
    }
    
    // Properties
    fileprivate var requestGroup: DispatchGroup?
    
    var updateUI: Closure?
    var presentError: ((_ errorMessage: String) -> ())?
    var startLoading: Closure?
}

extension BaseViewModel {
    
    // Multiple requests handling
    convenience init(isRequestGroup: Bool = false) {
        self.init()
        if !isRequestGroup {
            return
        }
        requestGroup = DispatchGroup()
    }
    
    func enterRequest() {
        requestGroup?.enter()
    }
    
    func leaveRequest() {
        requestGroup?.leave()
    }
    
    func notifyWhenRequestsCompleted(_ completionBlock: @escaping () -> ()) {
        requestGroup?.notify(queue: .main) {
            completionBlock()
        }
    }
    
    // Error message
    func showMessage(message: String) {
        presentError?(message)
    }
    
    func showError(of error: ErrorType) {
        switch error {
        case .clientError:
            presentError?("error_client".localized())
        case .serverError:
            presentError?("error_server".localized())
        case .unknown:
            presentError?("error_unknown".localized())
        }
    }
}
