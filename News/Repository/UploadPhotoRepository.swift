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

let catImageURL = "https://news-feed.dunice-testing.com/api/v1/file/2a168ee8-c989-41b4-ada8-990148ba21dd."
let cat2ImageURL = "https://news-feed.dunice-testing.com/api/v1/file/5e20eaf8-2d8a-4f5c-b659-68b4c0b84f4e."
let waterfall = "https://news-feed.dunice-testing.com/api/v1/file/27f87c66-07de-49a4-9417-9932c4b61d90."

protocol UploadPhotoRepositoryLogic {
    
    func uploadPhoto(_ image: UIImage) -> AnyPublisher<String, Error>
    
}

class UploadPhotoRepository : UploadPhotoRepositoryLogic {
    
    func uploadPhoto(_ image: UIImage) -> AnyPublisher<String, Error> {
        let jpegData = image.jpegData(compressionQuality: 0.5)!
        return AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(jpegData, withName: "file", fileName: "avatar\(Date())", mimeType: "image/jpg")
        }, to: API.uploadFileURL)
            .responseJSON { response in
                print(response)
            }
            .validate()
            .publishDecodable(type: UploadPhotoResponse.self, queue: .main)
            .value()
            .map{$0.data}
            .mapError{$0 as Error}
            .eraseToAnyPublisher()
    }
}
