//
//  NewsViewModel.swift
//  News
//
//  Created by dunice on 05.05.2022.
//

import Foundation
import Combine

protocol NewsBusinessLogic {
    
    func getNews(page: Int, perPage: Int)
}

class NewsViewModel: NewsBusinessLogic {
    
    let appState: AppState
    
    private let repository = NewsRepository()
    
    private var subscriptions: Set<AnyCancellable> = []
    
    init(appState: AppState) {
        self.appState = appState
        getNews(page: 1, perPage: 2)
    }
    
    func getNews(page: Int, perPage: Int) {
        print("gets called")
//        repository.getNewsURLSession(page: page, perPage: perPage)
        repository.getNewsURLSession(page: page, perPage: perPage)
            .sink(receiveCompletion: receiveCompletion(_:), receiveValue: { news in
                self.appState.news = news
            })
            .store(in: &subscriptions)
    }
    
    private func receiveCompletion(_ completion: Subscribers.Completion<Error>) {
        switch completion {
        case .failure(let error):
            appState.error = error.localizedDescription
        case .finished: appState.loadingState = .success
        }
    }
}
