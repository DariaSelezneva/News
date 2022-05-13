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
            .print()
            .eraseToAnyPublisher()
    }
    
    func findNews(page: Int, perPage: Int, keywords: String? = nil, user: String? = nil, tags: [String]? = nil) -> AnyPublisher<DataNewsResponse, Error> {
        var params: Parameters = [:]
        params["page"] = page
        params["perPage"] = perPage
        if let keywords = keywords {
            params["keywords"] = keywords
        }
        if let user = user {
            params["user"] = user
        }
        if let tags = tags, !tags.isEmpty {
            params["tags"] = tags
        }
        return AF.request(API.findNewsURL, method: .get, parameters: params, encoding: URLEncoding.default)
            .validate()
            .publishDecodable(type: DataNewsResponse.self, queue: .main)
            .value()
            .mapError({$0 as Error})
            .print()
            .eraseToAnyPublisher()
    }
}
