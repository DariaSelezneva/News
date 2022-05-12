//
//  UserViewModel.swift
//  News
//
//  Created by dunice on 05.05.2022.
//

import Foundation
import UIKit
import Combine

protocol UserBusinessLogic {
    
    func getUser(token: String)
    func updateUser(avatar: UIImage, name: String, email: String)
}

class UserViewModel : UserBusinessLogic {
    
    let appState: AppState
    
    private var newImageURL: String?
    
    private let userRepository: UserRepositoryLogic = UserRepository()
    private let uploadRepository: UploadPhotoRepositoryLogic = UploadPhotoRepository()
    
    private var subscriptions: Set<AnyCancellable> = []
    
    init(appState: AppState) {
        self.appState = appState
    }
    
    func getUser(token: String) {
        appState.loadingState = .loading
        userRepository.getUser(token: token)
            .sink(receiveCompletion: receiveCompletion(_ :),
                  receiveValue: { [weak self] in self?.appState.user = $0
                print($0)
            })
            .store(in: &subscriptions)
    }
    
    func updateUser(avatar: UIImage, name: String, email: String) {
        appState.loadingState = .loading
        uploadRepository.uploadPhoto(avatar)
            .sink(receiveCompletion: receiveCompletion(_ :),
                  receiveValue: { url in
                self.userRepository.updateUser(avatar: url, email: email, name: name)
                    .sink(receiveCompletion: self.receiveCompletion(_ :),
                          receiveValue: { self.appState.user = $0 })
                    .store(in: &self.subscriptions)
            })
            .store(in: &subscriptions)
    }
    
    private func receiveCompletion(_ completion: Subscribers.Completion<Error>) {
        switch completion {
        case .failure(let error):
            appState.error = error.localizedDescription
        case .finished: appState.loadingState = .success
        }
    }
}
