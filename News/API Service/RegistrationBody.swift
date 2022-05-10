//
//  RegistrationBody.swift
//  News
//
//  Created by Дарья Селезнёва on 09.05.2022.
//

import Foundation

struct RegistrationBody: Encodable {
    
    var avatar: String
    var email: String
    var name: String
    var password: String
    var role: String = "user"
    
}
