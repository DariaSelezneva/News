//
//  RegisterRepository.swift
//  News
//
//  Created by dunice on 05.05.2022.
//

import Foundation
import Combine
import Alamofire

let catImageURL = "https://news-feed.dunice-testing.com/api/v1/file/502f5549-98ad-4db5-903b-c8d445bd4369."
let cat2ImageURL = "https://news-feed.dunice-testing.com/api/v1/file/38a8e452-902f-4417-b429-b00773006368."

protocol RegistrationRepositoryLogic {
    
}

class RegisterRepository: RegistrationRepositoryLogic {
    
    func uploadPhotoPublisher(_ image: UIImage) -> AnyPublisher<String, Error>? {
        guard let pngData = image.pngData() else { return nil }
        return AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(pngData, withName: "file", fileName: "avatar\(Date())", mimeType: "image/png")
        }, to: API.uploadFileURL)
            .validate()
            .publishDecodable(type: UploadPhotoResponse.self, queue: .main)
            .value()
            .map{$0.data}
            .mapError{$0 as Error}
            .eraseToAnyPublisher()
//            .sink { completion in
//              print(completion)
//            } receiveValue: { imageURL in
//                print(imageURL)
//            }
//            .store(in: &subscriptions)

//        AF.upload(multipartFormData: { multipartFormData in
//            multipartFormData.append(pngData, withName: "file", fileName: "avatar\(Date())", mimeType: "image/png")
//        }, to: API.uploadFileURL) { encodingResult in
//            switch encodingResult {
//            case .success(let upload, _, _):
//                upload.responseJSON { response in
//                    let decoder = JSONDecoder()
//                    if let data = response.data {
//                        let uploadResponse = try? decoder.decode(UploadPhotoResponse.self, from: data)
//                        print(uploadResponse)
//                    }
//                }
//            case .failure(let error): print("error: \(error)")
//            }
//        }
    }
    
    func register(avatar: String, email: String, name: String, password: String) -> AnyPublisher<AuthResponse, Error> {
        let parameters = ["avatar" : avatar, "email" : email, "name" : name, "password" : password, "role" : "user"]
        let headers: HTTPHeaders = ["Content-Type" : "application/json"]
        return AF.request(API.registerURL, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .publishDecodable(type: AuthResponse.self, queue: .main)
            .value()
            .mapError{$0 as Error}
            .eraseToAnyPublisher()
//            .responseJSON { response in
//                let decoder = JSONDecoder()
//                if let data = response.data {
//                    let newUser = try? decoder.decode(RegistrationResponse.self, from: data)
//                    print(newUser)
//                }
//            }
    }
}
