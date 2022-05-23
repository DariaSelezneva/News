//
//  UserAuthViewModel.swift
//  News
//
//  Created by dunice on 23.05.2022.
//

import Foundation
import UIKit
import Combine
import SwiftUI

final class UserAuthViewModel: ObservableObject {
    
    @AppStorage("token") var token: String = ""

    @Published var loadingState: LoadingState = .idle
    @Published var error: String? {
        didSet {
            loadingState = .error
        }
    }
    
    @Published var user: User?
    @Published var selectedTab: Int = 0
    
    private let loginRepository: LoginRepositoryLogic = LoginRepository()
    private let registerRepository: RegistrationRepositoryLogic = RegisterRepository()
    
    private let userRepository: UserRepositoryLogic = UserRepository()
    private let uploadRepository: UploadPhotoRepositoryLogic = UploadPhotoRepository()
    
    private var subscriptions: Set<AnyCancellable> = []
    
    // MARK: - Login
    func login(email: String, password: String) {
        guard email.isValidEmail else { error = "Invalid email"; return }
        guard password.isValidPassword else { error = "Invalid password"; return }
        loadingState = .loading
        loginRepository.login(email: email, password: password)
            .sink(receiveCompletion: receiveCompletion(_:), receiveValue: { authResponse in
                self.token = authResponse.token
                self.user = User(id: authResponse.id, avatar: authResponse.avatar, email: authResponse.email, name: authResponse.name)
                self.selectedTab = 1
            })
            .store(in: &subscriptions)
    }
    
    // MARK: - Register
    @Published var selectedImage: UIImage = UIImage(named: "image-placeholder")!
    
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    
    func register() {
        guard email.isValidEmail else { error = "Invalid email"; return }
        guard password == confirmPassword else { error = "Password doesn't match confirmation"; return }
        guard password.isValidPassword else { error = "Invalid password"; return }
        loadingState = .loading
        uploadRepository.uploadPhoto(selectedImage)
            .flatMap( { [registerRepository] url in ((registerRepository.register(avatar: url, email: self.email, name: self.name, password: self.password))) })
            .sink(receiveCompletion: self.receiveCompletion(_:), receiveValue: { [weak self] authResponse in
                self?.user = User(id: authResponse.id, avatar: authResponse.avatar, email: authResponse.email, name: authResponse.name)
                self?.token = authResponse.token
                self?.selectedTab = 1
            })
            .store(in: &subscriptions)
    }
    
   // MARK: - User
    func getUser() {
        guard !token.isEmpty else { return }
        loadingState = .loading
        userRepository.getUser(token: token)
            .sink(receiveCompletion: receiveCompletion(_ :),
                  receiveValue: { [weak self] in self?.user = $0 })
            .store(in: &subscriptions)
    }
    
    func updateUser(avatar: UIImage, name: String, email: String) {
        loadingState = .loading
        uploadRepository.uploadPhoto(avatar)
            .flatMap({ [weak self, userRepository] url in
                userRepository.updateUser(token: self?.token ?? "", avatar: url, email: email, name: name) })
            .sink(receiveCompletion: self.receiveCompletion(_ :),
                  receiveValue: { self.user = $0 })
            .store(in: &self.subscriptions)
    }
    
    private func receiveCompletion(_ completion: Subscribers.Completion<Error>) {
        switch completion {
        case .failure(let error):
            self.error = error.localizedDescription
        case .finished: loadingState = .success
        }
    }
}
