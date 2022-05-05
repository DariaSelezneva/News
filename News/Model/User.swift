//
//  User.swift
//  News
//
//  Created by dunice on 05.05.2022.
//

import Foundation

let catPhotoURL = "https://cdn.shopify.com/s/files/1/1832/0821/files/catshark.jpg?v=1649869148"

struct User {
    
    var id: Int
    var avatar: String
    var email: String
    var name: String
    var role: String
    
}

extension User: Decodable {}

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
