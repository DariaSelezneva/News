//
//  PostCreationResponse.swift
//  News
//
//  Created by dunice on 17.05.2022.
//

import Foundation

struct PostCreationResponse : Decodable {
    
    var id: Int
    var success: Bool
    var statusCode: Int
}
