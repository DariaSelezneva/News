//
//  UserRepository.swift
//  News
//
//  Created by dunice on 05.05.2022.
//

import Foundation
import Alamofire
import Combine

protocol UserRepositoryLogic {
    
    func getUser(token: String) -> AnyPublisher<User, Error>
    func updateUser(token: String, avatar: String, email: String, name: String) -> AnyPublisher<User, Error>
}

class UserRepository: UserRepositoryLogic {
    
    func getUser(token: String) -> AnyPublisher<User, Error> {
        let headers: HTTPHeaders = [.authorization(token)]
        return AF.request(API.getUserInfoURL, method: .get, headers: headers)
            .validate()
            .publishDecodable(type: User.self, queue: .main)
            .value()
            .mapError({$0 as Error})
            .eraseToAnyPublisher()
    }
    
    func updateUser(token: String, avatar: String, email: String, name: String) -> AnyPublisher<User, Error> {
        let headers: HTTPHeaders = [.authorization(token)]
        let parameters = ["avatar" : avatar, "email" : email, "name" : name, "role" : "user"]
        return AF.request(API.userURL, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .publishDecodable(type: User.self, queue: .main)
            .value()
            .mapError({$0 as Error})
            .eraseToAnyPublisher()
    }
}
