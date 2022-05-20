//
//  AppState.swift
//  News
//
//  Created by dunice on 11.05.2022.
//

import Foundation
import Combine


class AppState: ObservableObject, Stateful {
    
    @Published var loadingState: LoadingState = .idle
    @Published var error: String? {
        didSet {
            loadingState = .error
        }
    }
    
    @Published var user: User?
}
