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
    @ObservedObject var appState: AppState
    
    init(appState: AppState) {
        self.appState = appState
    }
    
    @Published var emailValid: Bool = true
    
    @Published var error: String?
    
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
        appState.loadingState = .loading
        repository?.login(email: email, password: password)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.appState.loadingState = .error
                    self.appState.error = error.localizedDescription
                case .finished: self.appState.loadingState = .success
                }
            }, receiveValue: { authResponse in
                print(authResponse)
                self.appState.user = User(id: authResponse.id, avatar: authResponse.avatar, email: authResponse.email, name: authResponse.name)
                self.token = authResponse.token
            })
            .store(in: &subscriptions)
    }
}
