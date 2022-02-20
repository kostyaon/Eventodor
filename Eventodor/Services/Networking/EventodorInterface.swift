//
//  EventodorInterface.swift
//  Eventodor
//
//  Created by Petrykevich, Kanstantsin on 20.02.22.
//

import Foundation
import Alamofire

struct EventodorInterface{
    
    static func uploadToServer<T: Decodable>(type: T.Type, router: EndpointType, completion: @escaping (Result<T, Error>) -> Void) {
        AF.request(router.fullURL, method: router.httpMethod, parameters: router.parameters, encoding: JSONEncoding.default, headers: router.headers).responseDecodable(of: type) { response in
            if let error = response.error {
                completion(.failure(error))
                return
            }
            
            if let decodableModel = response.value {
                completion(.success(decodableModel))
            }
        }
    }
    
    static func loadFromServer<T: Decodable>(type: T.Type, router: EndpointType, completion: @escaping (Result<T, Error>) -> Void) {
        AF.request(router.fullURL, method: router.httpMethod, parameters: router.parameters, headers: router.headers).validate().responseDecodable(of: type) { response in
            if let error = response.error {
                completion(.failure(error))
            }
            
            if let decodableModel = response.value {
                completion(.success(decodableModel))
            }
        }
    }
}
