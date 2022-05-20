//
//  UserDataStorage.swift
//  News
//
//  Created by dunice on 19.05.2022.
//

import UIKit
import SwiftUI

final class UserDataStorage: ObservableObject, Stateful {
    
    @AppStorage("token") var token: String = ""
    
    @Published var loadingState: LoadingState = .idle
    @Published var error: String? {
        didSet {
            loadingState = .error
        }
    }
    
    @Published var user: User?
    
}
