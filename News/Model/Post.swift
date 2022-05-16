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
    var tags: [Tag]
    

    static let sample = Post(id: 1, userId: "", title: "Title", text: "Some long long multilined description, let's think what could I write here, maybe something about Doctor Who?", image: "", username: "John Smith", tags: [Tag(id: 1, title: "tag"), Tag(id: 2, title: "anothertag")])
    
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
        tags = try container.decode([Tag].self, forKey: .tags)
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
        try container.encode(tags.map({$0.title}), forKey: .tags)
    }
}
