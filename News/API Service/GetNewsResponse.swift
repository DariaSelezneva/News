//
//  GetNewsResponse.swift
//  News
//
//  Created by dunice on 05.05.2022.
//

import Foundation

struct GetNewsResponse {
    
    var posts: [Post]
    
}

extension GetNewsResponse: Decodable {
    
    enum RootCodingKeys: String, CodingKey {
        case data
    }
    
    enum ContentCodingKeys: String, CodingKey {
        case content
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootCodingKeys.self)
        let data = try container.nestedContainer(keyedBy: ContentCodingKeys.self, forKey: .data)
        posts = try data.decode([Post].self, forKey: .content)
    }
}
