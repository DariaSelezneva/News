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
    
    func getNews(page: Int, perPage: Int) -> AnyPublisher<[Post], Error>
}

class NewsRepository: NewsRepositoryLogic {
    
    func getNews(page: Int, perPage: Int) -> AnyPublisher<[Post], Error> {
        let headers: HTTPHeaders = ["Content-Type" : "application/json"]
        return AF.request(API.getNewsURL(page: page, perPage: perPage), headers: headers)
            .responseJSON(completionHandler: { response in
                print(response)
            })
            .validate()
            .publishDecodable(type: [Post].self, queue: .main)
            .value()
            .mapError({$0 as Error})
            .eraseToAnyPublisher()
    }
    
    func getNewsURLSession(page: Int, perPage: Int) -> AnyPublisher<[Post], Error> {
        var request = URLRequest(url: URL(string: API.getNewsURL(page: page, perPage: perPage))!)
        request.httpMethod = "GET"
        return URLSession.shared.dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .map { output -> [Post] in
                let data = output.data
                if let jsonDict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any],
                   let dataDict = jsonDict["data"] as? [String : Any],
                   let content = dataDict["content"] as? Array<[String : Any]> {
                    return content.compactMap { dict in Post.init(from: dict) }
                }
                else { return [] }
            }
            .mapError({ $0 as Error })
            .eraseToAnyPublisher()
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let data = data,
//               let jsonDict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any],
//               let dataDict = jsonDict["data"] as? [String : Any],
//               let content = dataDict["content"] as? Array<[String : Any]> {
//                let news = content.compactMap { dict in Post.init(from: dict) }
//                print(news)
//            }
//        }
//        .resume()
    }
}
