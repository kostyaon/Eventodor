//
//  EventodorRouter.swift
//  Eventodor
//
//  Created by Petrykevich, Kanstantsin on 20.02.22.
//

import Foundation
import Alamofire

enum EventodorRouter {
    
    // Authentication
    enum Auth {
        
        case register(String, String, String)
        case registerUser(User)
        case login(String, String)
    }
    
    // Category
    enum Category {
        
        case getCategories
    }
    
    // Event
    enum Event {
        
        case allEvents
        case myEvents
        case eventById(Int)
    }
}

// MARK: - Events
extension EventodorRouter.Event: EndpointType {
    
    var baseURL: String {
        "http://127.0.0.1:8000/api/v1"
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .allEvents, .eventById(_):
            return [
                "Cookie": "",
                "Content-Type": "application/json",
                "Authorization": "Token \((ConfigValues.tokenKey ?? ""))"
            ]
        case .myEvents:
            return [:]
        }
    }
    
    var path: String {
        switch self {
        case .allEvents:
            return "/event/"
        case .myEvents:
            return "/eventuser/"
        case .eventById(let id):
            return "/event/\(id)/"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .allEvents, .myEvents, .eventById(_):
            return [:]
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .allEvents, .myEvents, .eventById(_):
            return .get
        }
    }
    
    var fullURL: URL {
        switch self {
        default:
            return URL(string: self.baseURL + self.path)!
        }
    }
}

// MARK: - Category
extension EventodorRouter.Category: EndpointType {
    
    var baseURL: String {
        "http://127.0.0.1:8000/api/v1"
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .getCategories:
            return [
                "Cookie": "",
                "Content-Type": "application/json",
                "Authorization": "Token \((ConfigValues.tokenKey ?? ""))"
            ]
        }
    }
    
    var path: String {
        switch self {
        case .getCategories:
            return "/category/"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getCategories:
            return [:]
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getCategories:
            return .get
        }
    }
    
    var fullURL: URL {
        switch self {
        default:
            return URL(string: self.baseURL + self.path)!
        }
    }
}

// MARK: - Authentication
extension EventodorRouter.Auth: EndpointType {
    
    var baseURL: String {
        "http://127.0.0.1:8000/api/v1"
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .registerUser(_):
            return [
                "Cookie": "",
                "Content-Type": "application/json",
                "Authorization": "Token \((ConfigValues.tokenKey ?? ""))"
            ]
        case .register(_, _, _), .login(_, _):
            return [
                "Cookie": "",
                "Content-Type": "application/json"
            ]
        default:
            return [
                "Content-Type": "application/json",
                "Authorization": "Token \((ConfigValues.tokenKey ?? ""))"
            ]
        }
    }
    
    var path: String {
        switch self {
        case .registerUser(_):
            return "/user/"
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
        case .registerUser(let user):
            return [
                "photo_id": user.photo_id ?? 1,
                "name": user.name ?? "",
                "surname": user.surname ?? "",
                "patronymic": user.patronymic ?? "",
                "phone": user.phone ?? "",
                "email": user.email ?? "",
                "country": user.country ?? "",
                "city": user.city ?? "",
                "address": user.address ?? "",
                "bankAccount": user.bankAccount ?? ""
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
        case .register(_, _, _), .login(_, _), .registerUser(_):
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

