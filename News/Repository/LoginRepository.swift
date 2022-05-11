//
//  LoginRepository.swift
//  News
//
//  Created by dunice on 05.05.2022.
//

import Foundation
import Combine
import Alamofire

let user = User(id: "f52bec9a-e11e-46f7-8b0f-83aa58593dca",
                avatar: "https://news-feed.dunice-testing.com/api/v1/file/502f5549-98ad-4db5-903b-c8d445bd4369.",
                email: "example@bla.com",
                name: "NewUser",
                role: "user")
let password = "12345678"
let token = "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJmNTJiZWM5YS1lMTFlLTQ2ZjctOGIwZi04M2FhNTg1OTNkY2EiLCJleHAiOjE2NTM0MzY4MDB9.-OfbeDVJVIibMDczXmtTRWg0Taomirb0JsG2kEnVjgvekmOp1FEmoQIvni1hvnZTds6R8f_jAGYTawNe0nBRZg"

protocol LoginRepositoryLogic {
    
    func login(email: String, password: String) -> AnyPublisher<AuthResponse, Error>
    
}

class LoginRepository: LoginRepositoryLogic {
    
    func login(email: String, password: String) -> AnyPublisher<AuthResponse, Error> {
        let parameters = ["email" : email, "password" : password]
        let headers: HTTPHeaders = ["Content-Type" : "application/json"]
        return AF.request(API.loginURL, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .publishDecodable(type: AuthResponse.self, queue: .main)
            .value()
            .mapError({$0 as Error})
            .eraseToAnyPublisher()
    }
}
