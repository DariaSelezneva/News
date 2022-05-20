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

final class LoginViewModel: LoginBusinessLogic, ObservableObject {
    
    @AppStorage("token") var token: String = ""
    
    let appState: AppState
    
    init(appState: AppState) {
        self.appState = appState
    }
   
    let repository: LoginRepositoryLogic = LoginRepository()
    
    private var subscriptions: Set<AnyCancellable> = []
    
    func login(email: String, password: String) {
        guard email.isValidEmail else { appState.error = "Invalid email"; return }
        guard password.isValidPassword else { appState.error = "Invalid password"; return }
        appState.loadingState = .loading
        repository.login(email: email, password: password)
            .sink(receiveCompletion: appState.receiveCompletion(_:), receiveValue: { authResponse in
                self.appState.user = User(id: authResponse.id, avatar: authResponse.avatar, email: authResponse.email, name: authResponse.name)
                self.token = authResponse.token
            })
            .store(in: &subscriptions)
    }
}
