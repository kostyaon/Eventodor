//
//  EventodorRouter.swift
//  Eventodor
//
//  Created by Petrykevich, Kanstantsin on 20.02.22.
//

import Foundation
import Alamofire

enum EventodorRouter {
    
    case register(String, String, String)
    case login(String, String)
}

// MARK: - Extensions
extension EventodorRouter: EndpointType {
    
    var baseURL: String {
        "http://127.0.0.1:8000/api/v1"
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .register(_, _, _), .login(_, _):
            return [
                "Content-Type": "application/json"
            ]
        default:
            return [
                "Content-Type": "application/json",
                "Authorization": "Token \((UserDefaults.standard.string(forKey: "token") ?? ""))"
            ]
        }
    }
    
    var path: String {
        switch self {
        case .register(_, _, _):
            return "/registration/"
        case .login(_, _):
            return "/login/"
        default:
            return "/latest"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .register(let username, let email, let password):
            return [
                "username": username,
                "email": email,
                "password1": password,
                "password2": password
            ]
        case .login(let username, let password):
            return [
                "username": username,
                "password": password
            ]
            
        default:
            return nil
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .register(_, _, _), .login(_, _):
            return .post
        default:
            return .post
        }
    }
    
    var fullURL: URL {
        switch self {
        default:
            return URL(string: self.baseURL + self.path)!
        }
    }
}

