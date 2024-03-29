//
//  RegisterViewModel.swift
//  News
//
//  Created by dunice on 05.05.2022.
//

import Foundation
import UIKit
import SwiftUI
import Combine

protocol RegisterBusinessLogic: ObservableObject {
    func register()
}

final class RegisterViewModel: RegisterBusinessLogic {
    
    @AppStorage("token") var token: String = ""
    
    let appState: AppState
    let registerRepository: RegistrationRepositoryLogic
    let uploadRepository: UploadPhotoRepositoryLogic
    
    init(appState: AppState, registerRepository: RegistrationRepositoryLogic, uploadRepository: UploadPhotoRepositoryLogic) {
        self.appState = appState
        self.registerRepository = registerRepository
        self.uploadRepository = uploadRepository
    }
    
    @Published var selectedImage: UIImage = UIImage(named: "image-placeholder")!
    
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    
    private var subscriptions: Set<AnyCancellable> = []
    
    func register() {
        guard email.isValidEmail else { appState.error = "Invalid email"; return }
        guard password == confirmPassword else { appState.error = "Password doesn't match confirmation"; return }
        guard password.isValidPassword else { appState.error = "Invalid password"; return }
        appState.loadingState = .loading
        uploadRepository.uploadPhoto(selectedImage)
            .flatMap( { [registerRepository] url in ((registerRepository.register(avatar: url, email: self.email, name: self.name, password: self.password))) })
            .sink(receiveCompletion: self.appState.receiveCompletion(_:), receiveValue: { [weak self] authResponse in
                self?.appState.user = User(id: authResponse.id, avatar: authResponse.avatar, email: authResponse.email, name: authResponse.name)
                self?.token = authResponse.token
                self?.appState.selectedTab = 1
            })
            .store(in: &subscriptions)
    }
}
