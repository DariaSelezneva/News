//
//  LoginRepository.swift
//  News
//
//  Created by dunice on 05.05.2022.
//

import Foundation
import Combine
import Alamofire

protocol LoginRepositoryLogic {
    
    func login(email: String, password: String) -> AnyPublisher<AuthResponse, Error>
    
}

final class LoginRepository: LoginRepositoryLogic {
    
    func login(email: String, password: String) -> AnyPublisher<AuthResponse, Error> {
        let parameters = ["email" : email, "password" : password]
        let headers: HTTPHeaders = ["Content-Type" : "application/json"]
        return AF.request(API.loginURL, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .publishDecodable(type: AuthResponse.self, queue: .main)
            .value()
            .mapError({ $0 as Error})
            .eraseToAnyPublisher()
    }
}


final class LoginRepositoryMock: LoginRepositoryLogic {

    func login(email: String, password: String) -> AnyPublisher<AuthResponse, Error> {
        let authResponse = AuthResponse.mock(email: email)
        return Just(authResponse)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
