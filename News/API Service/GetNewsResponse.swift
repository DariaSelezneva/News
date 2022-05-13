//
//  GetNewsResponse.swift
//  News
//
//  Created by dunice on 05.05.2022.
//

import Foundation

struct GetNewsResponse: Decodable {
    var data: DataNewsResponse
    var statusCode: Int
    var success: Bool
}

struct DataNewsResponse: Decodable {
    var content: [Post]
    var numberOfElements: Int
}
