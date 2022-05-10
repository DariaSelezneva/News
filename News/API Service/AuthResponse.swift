//
//  AuthResponse.swift
//  News
//
//  Created by Дарья Селезнёва on 10.05.2022.
//

import Foundation

struct AuthResponse {
    
    var id: String
    var avatar: String
    var email: String
    var name: String
    var role: String
    var token: String
    
}

extension AuthResponse: Decodable {
    
    enum RootCodingKeys: String, CodingKey {
        case data
    }
    
    enum DataCodingKeys: String, CodingKey {
        case id, avatar, email, name, role, token
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootCodingKeys.self)
        let data = try container.nestedContainer(keyedBy: DataCodingKeys.self, forKey: .data)
        id = try data.decode(String.self, forKey: .id)
        avatar = try data.decode(String.self, forKey: .avatar)
        email = try data.decode(String.self, forKey: .email)
        name = try data.decode(String.self, forKey: .name)
        role = try data.decode(String.self, forKey: .role)
        token = try data.decode(String.self, forKey: .token)
    }
}
