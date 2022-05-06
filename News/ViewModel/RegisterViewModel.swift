//
//  RegisterViewModel.swift
//  News
//
//  Created by dunice on 05.05.2022.
//

import Foundation
import UIKit

protocol RegisterBusinessLogic {
    func register(avatar: UIImage, email: String, name: String, password: String)
}

class RegisterViewModel: RegisterBusinessLogic {
    
    func register(avatar: UIImage, email: String, name: String, password: String) {
        
    }
}
