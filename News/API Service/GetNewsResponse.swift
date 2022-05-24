//
//  GetNewsResponse.swift
//  News
//
//  Created by dunice on 05.05.2022.
//

import Foundation

struct DataNewsResponse: Decodable {
    
    var content: [Post]
    var numberOfElements: Int
    
}
