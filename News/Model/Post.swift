//
//  Post.swift
//  News
//
//  Created by dunice on 05.05.2022.
//

import Foundation

struct Post {
    
    var id: Int
    var userId: String
    var title: String
    var description: String
    var image: String
    var username: String
    var tags: [Tag]
    
}

extension Post: Decodable {}

extension Post: Encodable {
    
    enum EncodingKeys: String, CodingKey {
        case title, description, image, tags
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EncodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(description, forKey: .description)
        try container.encode(image, forKey: .image)
        try container.encode(tags.map({$0.title}), forKey: .tags)
    }
}
