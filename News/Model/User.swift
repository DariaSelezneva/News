//
//  User.swift
//  News
//
//  Created by dunice on 05.05.2022.
//

import Foundation
import UIKit

struct User {
    
    var id: String
    var avatar: String
    var email: String
    var name: String
    var role: String = "user"
    
}

extension User: Decodable {
    
    enum RootCodingKeys: String, CodingKey {
        case data
    }

    enum DataCodingKeys: String, CodingKey {
        case id, avatar, email, name, role
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootCodingKeys.self)
        let data = try container.nestedContainer(keyedBy: DataCodingKeys.self, forKey: .data)
        id = try data.decode(String.self, forKey: .id)
        avatar = try data.decode(String.self, forKey: .avatar)
        email = try data.decode(String.self, forKey: .email)
        name = try data.decode(String.self, forKey: .name)
        role = try data.decode(String.self, forKey: .role)
    }
}

extension User: Encodable {
    
    enum EncodingKeys: String, CodingKey {
        case avatar, email, name, role
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EncodingKeys.self)
        try container.encode(avatar, forKey: .avatar)
        try container.encode(email, forKey: .email)
        try container.encode(name, forKey: .name)
        try container.encode(role, forKey: .role)
    }
}

extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
            return lhs.id == rhs.id
        }
}
