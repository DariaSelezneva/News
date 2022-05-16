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
    
    func getNews(page: Int, perPage: Int) -> AnyPublisher<DataNewsResponse, Error>
}

class NewsRepository: NewsRepositoryLogic {
    
    func getNews(page: Int, perPage: Int) -> AnyPublisher<DataNewsResponse, Error> {
        var params: Parameters = [:]
        params["page"] = page
        params["perPage"] = perPage
        return AF.request(API.getNewsURL, method: .get, parameters: params, encoding: URLEncoding.default)
            .validate()
            .publishDecodable(type: GetNewsResponse.self, queue: .main)
            .value()
            .map({$0.data})
            .mapError({$0 as Error})
            .eraseToAnyPublisher()
    }
    
    func findNews(page: Int, perPage: Int, keywords: String? = nil, author: String? = nil, tags: [String]? = nil) -> AnyPublisher<DataNewsResponse, Error> {
        var params: Parameters = [:]
        params["page"] = page
        params["perPage"] = perPage
        if let keywords = keywords {
            params["keywords"] = keywords
        }
        if let author = author {
            params["author"] = author
        }
        if let tags = tags, !tags.isEmpty {
            let concatenated = tags.joined(separator: ",")
            params["tags"] = concatenated
        }
        return AF.request(API.findNewsURL, method: .get, parameters: params, encoding: URLEncoding.default)
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
}
