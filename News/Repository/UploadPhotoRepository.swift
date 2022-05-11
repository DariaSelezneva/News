//
//  UploadPhotoRepository.swift
//  News
//
//  Created by dunice on 11.05.2022.
//

import Foundation
import UIKit
import Combine
import Alamofire

let catImageURL = "https://news-feed.dunice-testing.com/api/v1/file/502f5549-98ad-4db5-903b-c8d445bd4369."
let cat2ImageURL = "https://news-feed.dunice-testing.com/api/v1/file/38a8e452-902f-4417-b429-b00773006368."

protocol UploadPhotoRepositoryLogic {
    
    func uploadPhoto(_ image: UIImage) -> AnyPublisher<String, Error>
    
}

class UploadPhotoRepository : UploadPhotoRepositoryLogic {
    
    func uploadPhoto(_ image: UIImage) -> AnyPublisher<String, Error> {
        let pngData = image.pngData()!
        return AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(pngData, withName: "file", fileName: "avatar\(Date())", mimeType: "image/png")
        }, to: API.uploadFileURL)
            .validate()
            .publishDecodable(type: UploadPhotoResponse.self, queue: .main)
            .value()
            .map{$0.data}
            .mapError{$0 as Error}
            .eraseToAnyPublisher()
    }
    
    func uploadPhoto(_ image: UIImage) {
        let pngData = image.pngData()!
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(pngData, withName: "file", fileName: "avatar\(Date())", mimeType: "image/png")
        }, to: API.uploadFileURL)
        .responseJSON { response in
            print(response)
        }
    }
}
