//
//  Tag.swift
//  News
//
//  Created by dunice on 05.05.2022.
//

import Foundation

struct Tag: Codable, Identifiable {
    
    var id: Int
    var title: String
    
}

extension Tag: Equatable {}
