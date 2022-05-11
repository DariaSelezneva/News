//
//  RegisterRepository.swift
//  News
//
//  Created by dunice on 05.05.2022.
//

import Foundation
import Combine
import Alamofire

protocol RegistrationRepositoryLogic {
    
    func register(avatar: String, email: String, name: String, password: String) -> AnyPublisher<AuthResponse, Error>
}


class RegisterRepository: RegistrationRepositoryLogic {
    
    func register(avatar: String, email: String, name: String, password: String) -> AnyPublisher<AuthResponse, Error> {
        let parameters = ["avatar" : avatar, "email" : email, "name" : name, "password" : password, "role" : "user"]
        let headers: HTTPHeaders = ["Content-Type" : "application/json"]
        return AF.request(API.registerURL, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .publishDecodable(type: AuthResponse.self, queue: .main)
            .value()
            .mapError{$0 as Error}
            .eraseToAnyPublisher()
    }
}
