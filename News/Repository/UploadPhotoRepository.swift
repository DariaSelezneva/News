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

protocol UploadPhotoRepositoryLogic {
    
    func uploadPhoto(_ image: UIImage) -> AnyPublisher<String, Error>
    
}

class UploadPhotoRepository : UploadPhotoRepositoryLogic {
    
    func uploadPhoto(_ image: UIImage) -> AnyPublisher<String, Error> {
        let jpegData = image.jpegData(compressionQuality: 0.5)!
        return AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(jpegData, withName: "file", fileName: "avatar\(Date())", mimeType: "image/jpg")
        }, to: API.uploadFileURL)
            .validate()
            .publishDecodable(type: UploadPhotoResponse.self, queue: .main)
            .value()
            .map{$0.data}
            .mapError{$0 as Error}
            .eraseToAnyPublisher()
    }
}
