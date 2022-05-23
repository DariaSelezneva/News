//
//  UserViewModel.swift
//  News
//
//  Created by dunice on 05.05.2022.
//

import Foundation
import UIKit
import Combine
import SwiftUI


final class UserViewModel {
    
    @AppStorage("token") var token: String = ""
    
    let appState: AppState
    
    init(appState: AppState) {
        self.appState = appState
    }
    
    private let userRepository: UserRepositoryLogic = UserRepository()
    private let uploadRepository: UploadPhotoRepositoryLogic = UploadPhotoRepository()
    
    private var subscriptions: Set<AnyCancellable> = []
    
    func getUser() {
        guard !token.isEmpty else { return }
        appState.loadingState = .loading
        userRepository.getUser(token: token)
            .sink(receiveCompletion: receiveCompletion(_ :),
                  receiveValue: { [weak self] in self?.appState.user = $0 })
            .store(in: &subscriptions)
    }
    
    func updateUser(avatar: UIImage, name: String, email: String) {
        appState.loadingState = .loading
        uploadRepository.uploadPhoto(avatar)
            .flatMap({ [weak self, userRepository] url in
                userRepository.updateUser(token: self?.token ?? "", avatar: url, email: email, name: name) })
            .sink(receiveCompletion: self.receiveCompletion(_ :),
                  receiveValue: { self.appState.user = $0 })
            .store(in: &self.subscriptions)
    }
    
    private func receiveCompletion(_ completion: Subscribers.Completion<Error>) {
        switch completion {
        case .failure(let error):
            appState.error = error.localizedDescription
        case .finished: appState.loadingState = .success
        }
    }
}
