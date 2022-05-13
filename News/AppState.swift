//
//  AppState.swift
//  News
//
//  Created by dunice on 11.05.2022.
//

import Foundation
import UIKit

enum LoadingState {
    case idle
    case loading
    case success
    case error
}

protocol Stateful {
    var loadingState: LoadingState { get set }
    var error: String? { get set }
}

class AppState: ObservableObject, Stateful {
    
    @Published var loadingState: LoadingState = .idle
    @Published var error: String? {
        didSet {
            loadingState = .error
        }
    }
    
    @Published var user: User? 
    @Published var userImage: UIImage?
    
    

}
