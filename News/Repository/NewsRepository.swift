//
//  NewsRepository.swift
//  News
//
//  Created by dunice on 05.05.2022.
//

import Foundation
import Alamofire
import Combine

protocol NewsRepositoryLogic {
    
    func getNews(page: Int, perPage: Int, keywords: String?, author: String?, tags: [String]?) -> AnyPublisher<DataNewsResponse, Error>
    func getUser(id: String) -> AnyPublisher<User, Error>
    
}

class NewsRepository: NewsRepositoryLogic {
    
    func getNews(page: Int, perPage: Int, keywords: String? = nil, author: String? = nil, tags: [String]? = nil) -> AnyPublisher<DataNewsResponse, Error> {
        var parameters: Parameters = [:]
        parameters["page"] = page
        parameters["perPage"] = perPage
        if let keywords = keywords {
            parameters["keywords"] = keywords
        }
        if let author = author {
            parameters["author"] = author
        }
        if let tags = tags, !tags.isEmpty {
            let concatenated = tags.joined(separator: ",")
            parameters["tags"] = concatenated
        }
        return AF.request(API.findNewsURL, method: .get, parameters: parameters, encoding: URLEncoding.default)
            .validate()
            .publishDecodable(type: DataNewsResponse.self, queue: .main)
            .value()
            .mapError({$0 as Error})
            .eraseToAnyPublisher()
    }
    
    func getUser(id: String) -> AnyPublisher<User, Error> {
        return AF.request(API.userURL.appending("/\(id)"), method: .get)
            .validate()
            .publishDecodable(type: User.self, queue: .main)
            .value()
            .mapError({$0 as Error})
            .eraseToAnyPublisher()
    }
    
    
    func createPost(imageURL: String, title: String, text: String, tags: [String], token: String) -> AnyPublisher<Int, Error> {
        let headers: HTTPHeaders = [
                 .authorization(token),
                 .accept("application/json")
                ]
        let body = PostCreationBody(image: imageURL, title: title, description: text, tags: tags)
        return AF.request(API.newsURL, method: .post, parameters: body, encoder: JSONParameterEncoder.default, headers: headers)
            .validate()
            .publishDecodable(type: PostCreationResponse.self, queue: .main)
            .value()
            .map({ $0.id })
            .mapError({$0 as Error})
            .eraseToAnyPublisher()
    }
    
    
    func updatePost(id: Int, imageURL: String, title: String, text: String, tags: [String], token: String) -> AnyPublisher<Bool, Error> {
        let headers: HTTPHeaders = [.authorization(token)]
        let body = PostCreationBody(image: imageURL, title: title, description: text, tags: tags)
        return AF.request(API.newsURL.appending("/\(id)"), method: .put, parameters: body, encoder: JSONParameterEncoder.default, headers: headers)
            .validate()
            .publishDecodable(type: SuccessResponse.self, queue: .main)
            .value()
            .map({ $0.success })
            .mapError({$0 as Error})
            .eraseToAnyPublisher()
    }
    
    func deletePost(id: Int, token: String) -> AnyPublisher<Bool, Error> {
        let headers: HTTPHeaders = [.authorization(token)]
        return AF.request(API.newsURL.appending("/\(id)"), method: .delete, headers: headers)
            .validate()
            .publishDecodable(type: SuccessResponse.self, queue: .main)
            .value()
            .map({ $0.success })
            .mapError({$0 as Error})
            .eraseToAnyPublisher()
    }
}
