//
//  TokenResponse.swift
//  News
//
//  Created by dunice on 05.05.2022.
//

import Foundation

struct TokenResponse {
    
    var token: String
    
}

extension TokenResponse: Decodable {
    
    enum RootCodingKeys: String, CodingKey {
        case data
    }
    
    enum DataCodingKeys: String, CodingKey {
        case token
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootCodingKeys.self)
        let data = try container.nestedContainer(keyedBy: DataCodingKeys.self, forKey: .data)
        token = try data.decode(String.self, forKey: .token)
    }
}
