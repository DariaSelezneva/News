//
//  p_Stateful.swift
//  News
//
//  Created by dunice on 19.05.2022.
//

import Foundation
import Combine

enum LoadingState {
    case idle
    case loading
    case success
    case error
}

protocol Stateful: AnyObject {
    var loadingState: LoadingState { get set }
    var error: String? { get set }
}

extension Stateful {
    
    func receiveCompletion(_ completion: Subscribers.Completion<Error>) {
        switch completion {
        case .failure(let error):
            self.error = error.localizedDescription
            loadingState = .error
        case .finished: loadingState = .success
        }
    }
}
