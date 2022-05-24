//
//  EventodorInterface.swift
//  Eventodor
//
//  Created by Petrykevich, Kanstantsin on 20.02.22.
//

import Foundation
import Alamofire

struct EventodorInterface {
    
    static func uploadToServer(router: EndpointType, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        AF.request(router.fullURL, method: router.httpMethod, parameters: router.parameters, encoding: JSONEncoding.default, headers: router.headers).response { AFResponse in
            if let error = AFResponse.error {
                completion(.failure(error))
                return
            }
            
            let jsonResponse = try? JSONSerialization.jsonObject(with: AFResponse.data!, options: []) as? [String: Any]
            completion(.success(jsonResponse ?? [:]))
        }
    }
    
    static func loadFromServer(router: EndpointType, completion: @escaping (Result<Any?, Error>) -> Void) {
        AF.request(router.fullURL, method: router.httpMethod, parameters: router.parameters, headers: router.headers).response { AFResponse in
            if let error = AFResponse.error {
                completion(.failure(error))
                return
            }
            
            let jsonResponse = try? JSONSerialization.jsonObject(with: AFResponse.data!, options: [])
            completion(.success(jsonResponse))
        }
    }
}

