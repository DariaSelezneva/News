//
//  AppState.swift
//  News
//
//  Created by dunice on 11.05.2022.
//

import Foundation
import Combine
import SwiftUI


final class AppState: ObservableObject, Stateful {
    
    // MARK: - Stored properties
    
    @AppStorage("token") var token: String = ""
    
    @Published var user: User?
    @Published var selectedTab: Int = 0
    
    // MARK: - Stateful
    
    @Published var loadingState: LoadingState = .idle
    @Published var error: String? {
        didSet {
            loadingState = .error
        }
    }
}
