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
    
    #if DEBUG
    static let mock = [
        Post(id: 3767, userId: "f52bec9a-e11e-46f7-8b0f-83aa58593dca", title: "Cat", text: "What do you want from me, human?", image: "https://news-feed.dunice-testing.com/api/v1/file/2d58842e-80b0-4491-974b-922431b65483.", username: "Daria", tags: []),
        Post(id: 3768, userId: "f52bec9a-e11e-46f7-8b0f-83aa58593dca", title: "Expecto patronum", text: "Asrdhtjfgkhk", image: "https://news-feed.dunice-testing.com/api/v1/file/825bdffb-c211-468f-a26b-bc2f12a3b281.", username: "Daria", tags: []),
        Post(id: 3769, userId: "f52bec9a-e11e-46f7-8b0f-83aa58593dca", title: "Tardis", text: "Wibbly-wobbly timely-wimey #stuff", image: "https://news-feed.dunice-testing.com/api/v1/file/ca87f775-d254-4275-b070-80c7547e2b94.", username: "Daria", tags: ["stuff"]),
        Post(id: 3780, userId: "f52bec9a-e11e-46f7-8b0f-83aa58593dca", title: "Join me in the Dark Side", text: "We have #cookies!", image: "https://news-feed.dunice-testing.com/api/v1/file/70b02f1d-5340-4dad-87cc-29506c7f4668.", username: "Daria", tags: ["cookies"]),
        Post(id: 3796, userId: "f52bec9a-e11e-46f7-8b0f-83aa58593dca", title: "Awsefdghdsfdgh", text: "Sdfghn", image: "https://news-feed.dunice-testing.com/api/v1/file/ecc82888-81a7-483a-bf69-c9ad3dc77425.", username: "Daria", tags: [])]
    #endif
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
