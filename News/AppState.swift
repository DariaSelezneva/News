//
//  AppState.swift
//  News
//
//  Created by dunice on 11.05.2022.
//

import Foundation
import Combine
import SwiftUI


class AppState: ObservableObject, Stateful {
    
    @Published var loadingState: LoadingState = .idle
    @Published var error: String? {
        didSet {
            loadingState = .error
        }
    }
    
    @AppStorage("token") var token: String = ""
    
    @Published var user: User?
    @Published var selectedTab: Int = 0
}
