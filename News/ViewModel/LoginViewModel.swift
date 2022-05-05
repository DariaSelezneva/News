//
//  LoginViewModel.swift
//  News
//
//  Created by dunice on 05.05.2022.
//

import Foundation

protocol LoginBusinessLogic {
    
    func login(email: String, password: String)
}

class LoginViewModel: LoginBusinessLogic {
    
    func login(email: String, password: String) {
        
    }
}
