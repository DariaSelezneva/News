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


final class UserRepository: UserRepositoryLogic {
    
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

final class UserRepositoryMock: UserRepositoryLogic {
    
    func getUser(token: String) -> AnyPublisher<User, Error> {
        Just(User.mock)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func updateUser(token: String, avatar: String, email: String, name: String) -> AnyPublisher<User, Error> {
        var user = User.mock
        user.avatar = avatar
        user.email = email
        user.name = name
        return Just(user)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
