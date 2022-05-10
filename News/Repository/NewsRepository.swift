//
//  NewsRepository.swift
//  News
//
//  Created by dunice on 05.05.2022.
//

import Foundation
import Alamofire

protocol NewsRepositoryLogic {
    
}

class NewsRepository {
    
    static func getNews(page: Int, perPage: Int) {
        AF.request(API.getNewsURL(page: page, perPage: perPage))
            .validate()
            .responseJSON { data in
                print(data)
            }
    }
}
