//
//  UploadPhotoResponse.swift
//  News
//
//  Created by dunice on 05.05.2022.
//

import Foundation

struct UploadPhotoResponse: Decodable {
    
    var data: String
    var statusCode: Int
    var success: Bool
        
}
