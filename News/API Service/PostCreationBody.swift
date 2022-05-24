//
//  PostCreationBody.swift
//  News
//
//  Created by dunice on 17.05.2022.
//

import Foundation

struct PostCreationBody: Encodable {
    
    var image: String
    var title: String
    var description: String
    var tags: [String]

}
