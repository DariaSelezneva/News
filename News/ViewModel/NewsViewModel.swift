//
//  NewsViewModel.swift
//  News
//
//  Created by dunice on 05.05.2022.
//

import Foundation
import Combine

protocol NewsBusinessLogic {
    
    func getNews()
    func loadMore()
}

class NewsViewModel: NewsBusinessLogic, ObservableObject {
    
    @Published var news: [Post] = []
    
    @Published var loadingState: LoadingState = .idle
    @Published var error: String? {
        didSet {
            loadingState = .error
        }
    }
    
    private let repository = NewsRepository()
    
    private var subscriptions: Set<AnyCancellable> = []
    
    init() {
        getNews()
    }
    
    var page: Int = 1
    var perPage: Int = 10
    var numberOfElements: Int = 0
    var isMore: Bool { numberOfElements > news.count }
    var query: String?
    var tags: [String] = []
    
    func getNews() {
        loadingState = .loading
        repository.getNews(page: 1, perPage: perPage)
            .sink(receiveCompletion: receiveCompletion(_:), receiveValue: { data in
                self.numberOfElements = data.numberOfElements
                self.news = data.content
            })
            .store(in: &subscriptions)
    }
    
    func findNews() {
        loadingState = .loading
        repository.findNews(page: 1, perPage: perPage, keywords: query, tags: tags)
            .sink(receiveCompletion: receiveCompletion(_:), receiveValue: { data in
                self.numberOfElements = data.numberOfElements
                self.news = data.content
            })
            .store(in: &subscriptions)
    }
    
    func loadMore() {
        if isMore {
            loadingState = .loading
            page += 1
            repository.findNews(page: page, perPage: perPage, keywords: query, tags: tags)
                .sink(receiveCompletion: receiveCompletion(_:), receiveValue: { data in
                    self.news.append(contentsOf: data.content)
                })
                .store(in: &subscriptions)
        }
    }
    
    private func receiveCompletion(_ completion: Subscribers.Completion<Error>) {
        switch completion {
        case .failure(let error):
            self.error = error.localizedDescription
        case .finished: loadingState = .success
        }
    }
}


