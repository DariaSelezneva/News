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

class LoginRepository: LoginRepositoryLogic {
    
    var cb: ((Bool) -> ())? = nil
    
    func login(email: String, password: String) -> AnyPublisher<AuthResponse, Error> {
        if let cb = cb {
            cb(true)
        }
        let parameters = ["email" : email, "password" : password]
        let headers: HTTPHeaders = ["Content-Type" : "application/json"]
        return AF.request(API.loginURL, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON(completionHandler: { response in
                print(response)
            })
//            .validate()
            .publishDecodable(type: AuthResponse.self, queue: .main)
            .value()
            .mapError({ error in
                print(error)
                return error as Error})
            .eraseToAnyPublisher()
    }
    
    func login(email: String, password: String, completion: @escaping (Bool) ->()) {
        cb = completion
//        URLSession.shared.dataTask(with: URL(string: API.loginURL)!) { data, _, _ in
//            completion(true)
//        }
    }
}
