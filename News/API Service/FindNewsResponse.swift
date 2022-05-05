//
//  FindNewsResponse.swift
//  News
//
//  Created by dunice on 05.05.2022.
//

import Foundation

struct FindNewsResponse {
    
    var posts: [Post]
    
}

extension FindNewsResponse: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case content
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        posts = try container.decode([Post].self, forKey: .content)
    }
}
