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
    func login()
}

final class LoginViewModel: LoginBusinessLogic, ObservableObject {
    
    @AppStorage("token") var token: String = ""
    
    let appState: AppState
    let repository: LoginRepositoryLogic
    
    init(appState: AppState, repository: LoginRepositoryLogic) {
        self.appState = appState
        self.repository = repository
    }
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    private var subscriptions: Set<AnyCancellable> = []
    
    func login() {
        guard email.isValidEmail else { appState.error = "Invalid email"; return }
        guard password.isValidPassword else { appState.error = "Invalid password"; return }
        appState.loadingState = .loading
        repository.login(email: email, password: password)
            .sink(receiveCompletion: appState.receiveCompletion(_:), receiveValue: { [weak self] authResponse in
                print(authResponse)
                self?.token = authResponse.token
                self?.appState.user = User(id: authResponse.id, avatar: authResponse.avatar, email: authResponse.email, name: authResponse.name)
                self?.appState.selectedTab = 1
            })
            .store(in: &subscriptions)
    }
}
