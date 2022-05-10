//
//  LoginViewModel.swift
//  News
//
//  Created by dunice on 05.05.2022.
//

import Foundation
import Combine
import SwiftUI

protocol LoginBusinessLogic {
    
    func login(email: String, password: String)
}

class LoginViewModel: LoginBusinessLogic, ObservableObject {
    
    @AppStorage("token") var token: String = ""
    
    @Published var emailValid: Bool = true
    
    var repository: LoginRepositoryLogic? = LoginRepository()
    
    var subscriptions: Set<AnyCancellable> = []
    
    func validateInput(email: String, password: String) -> String? {
        if email.isEmpty, !email.contains("@"), email.contains(" ") {
            emailValid = false
            return "Incorrect email"
        }
        if password.count < 6 {
            return "Password is too short"
        }
        else {
            return nil
        }
    }
    
    func login(email: String, password: String) {
        repository?.loginPublisher(email: email, password: password)
            .sink(receiveCompletion: { completion in
                print(completion)
            }, receiveValue: { authResponse in
                print(authResponse)
            })
            .store(in: &subscriptions)
    }
}
