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

final class UploadPhotoRepository : UploadPhotoRepositoryLogic {
    
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

final class UploadPhotoRepositoryMock : UploadPhotoRepositoryLogic {
    
    func uploadPhoto(_ image: UIImage) -> AnyPublisher<String, Error> {
        let url = "https://news-feed.dunice-testing.com/api/v1/file/693d86bf-fedd-47e8-8f00-332780ab46b8."
        return Just(url)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
