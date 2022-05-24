//
//  BaseViewModel.swift
//  Eventodor
//
//  Created by Petrykevich, Kanstantsin on 24.05.22.
//

import Foundation

public typealias Closure = (() -> ())

class BaseViewModel: NSObject {
    
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
    
}
