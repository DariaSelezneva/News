//
//  Post.swift
//  News
//
//  Created by dunice on 05.05.2022.
//

import Foundation

struct Post : Identifiable {
    
    var id: Int
    var userId: String
    var title: String
    var text: String
    var image: String
    var username: String
    var tags: [String]
    
    init(id: Int, userId: String, title: String, text: String, image: String, username: String, tags: [String]) {
        self.id = id
        self.userId = userId
        self.title = title
        self.text = text
        self.image = image
        self.username = username
        self.tags = tags
    }
}

extension Post: Equatable {
    static func ==(lhs: Post, rhs: Post) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Post: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case id, userId, title, text = "description", image, username, tags
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        userId = try container.decode(String.self, forKey: .userId)
        title = try container.decode(String.self, forKey: .title)
        text = try container.decode(String.self, forKey: .text)
        image = try container.decode(String.self, forKey: .image)
        username = try container.decode(String.self, forKey: .username)
        let tagsWithID = try container.decode([Tag].self, forKey: .tags)
        tags = tagsWithID.map({ $0.title })
    }
}

extension Post: Encodable {
    
    enum EncodingKeys: String, CodingKey {
        case title, text = "description", image, tags
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EncodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(text, forKey: .text)
        try container.encode(image, forKey: .image)
        try container.encode(tags, forKey: .tags)
    }
}
