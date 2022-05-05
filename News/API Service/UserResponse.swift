//
//  UserResponse.swift
//  News
//
//  Created by dunice on 05.05.2022.
//

import Foundation

struct UserResponse {
    
    var id: Int
    var avatar: String
    var email: String
    var name: String
    var role: String
    
}

extension UserResponse: Decodable {
    
    enum RootCodingKeys: String, CodingKey {
        case data
    }
    
    enum DataCodingKeys: String, CodingKey {
        case id, avatar, email, name, role
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootCodingKeys.self)
        let data = try container.nestedContainer(keyedBy: DataCodingKeys.self, forKey: .data)
        id = try data.decode(Int.self, forKey: .id)
        avatar = try data.decode(String.self, forKey: .avatar)
        email = try data.decode(String.self, forKey: .email)
        name = try data.decode(String.self, forKey: .name)
        role = try data.decode(String.self, forKey: .role)
    }
}
