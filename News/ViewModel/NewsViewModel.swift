//
//  NewsViewModel.swift
//  News
//
//  Created by dunice on 05.05.2022.
//

import Foundation
import Combine
import UIKit

protocol NewsBusinessLogic {
    
    func getNews()
    func loadMore()
    func getUser(id: String)
}

class NewsViewModel: NewsBusinessLogic, ObservableObject {
    
    @Published var news: [Post] = []
    
    @Published var loadingState: LoadingState = .idle
    @Published var error: String? {
        didSet {
            loadingState = .error
        }
    }
    
    private let newsRepository = NewsRepository()
    private let uploadRepository: UploadPhotoRepositoryLogic = UploadPhotoRepository()
    
    private var subscriptions: Set<AnyCancellable> = []
    
    var page: Int = 1
    var perPage: Int = 10
    var numberOfElements: Int = 0
    var isMore: Bool { numberOfElements > news.count }
    var query: String?
    var selectedUser: User?
    var tags: [String] = []
    
    @Published var editingPost: Post?
 
    func getNews() {
        loadingState = .loading
        newsRepository.getNews(page: 1, perPage: perPage, keywords: query, author: selectedUser?.name, tags: tags)
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
            newsRepository.getNews(page: page, perPage: perPage, keywords: query, author: selectedUser?.name, tags: tags)
                .sink(receiveCompletion: receiveCompletion(_:), receiveValue: { data in
                    self.news.append(contentsOf: data.content)
                })
                .store(in: &subscriptions)
        }
    }
    
    func getUser(id: String) {
        newsRepository.getUser(id: id)
            .sink(receiveCompletion: receiveCompletion(_:), receiveValue: { user in
                self.selectedUser = user
                self.getNews()
            })
            .store(in: &subscriptions)
    }
    
    func createPost(image: UIImage, title: String, text: String, tags: [String]) {
        guard let token = UserDefaults.standard.string(forKey: "token"), !token.isEmpty else { return }
        loadingState = .loading
        uploadRepository.uploadPhoto(image)
            .sink(receiveCompletion: receiveCompletion(_ :),
                  receiveValue: { url in
                self.newsRepository.createPost(imageURL: url, title: title, text: text, tags: tags, token: token)
                    .sink(receiveCompletion: self.receiveCompletion(_:), receiveValue: { id in
                        guard var post = self.editingPost else { return }
                        post.id = id
                        self.editingPost = nil
                        self.news.insert(post, at: 0)
                    })
                    .store(in: &self.subscriptions)
            })
            .store(in: &subscriptions)
    }
    
    func updatePost(id: Int, image: UIImage, title: String, text: String, tags: [String]) {
        guard let token = UserDefaults.standard.string(forKey: "token"), !token.isEmpty else { return }
        loadingState = .loading
        uploadRepository.uploadPhoto(image)
            .sink(receiveCompletion: receiveCompletion(_ :),
                  receiveValue: { url in
                self.newsRepository.updatePost(id: id, imageURL: url, title: title, text: text, tags: tags, token: token)
                    .sink(receiveCompletion: self.receiveCompletion(_:), receiveValue: { success in
                        guard let post = self.editingPost, let index = self.news.firstIndex(of: post) else { return }
                        self.editingPost = nil
                        self.news[index] = post
                    })
                    .store(in: &self.subscriptions)
            })
            .store(in: &subscriptions)
    }
    
    func deletePost(id: Int) {
        loadingState = .loading
        guard let token = UserDefaults.standard.string(forKey: "token") else { return }
        newsRepository.deletePost(id: id, token: token)
            .sink(receiveCompletion: receiveCompletion(_:), receiveValue: { success in
                if success {
                    self.news = self.news.filter({ $0.id != id })
                }
                else {
                    self.error = "Unknown error"
                }
            })
            .store(in: &subscriptions)
    }
    
    private func receiveCompletion(_ completion: Subscribers.Completion<Error>) {
        switch completion {
        case .failure(let error):
            self.error = error.localizedDescription
        case .finished: loadingState = .success
        }
    }
}


