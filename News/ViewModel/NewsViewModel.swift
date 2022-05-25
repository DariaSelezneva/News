//
//  NewsViewModel.swift
//  News
//
//  Created by dunice on 05.05.2022.
//

import Foundation
import Combine
import UIKit

enum AppError: Error {
    case internalError
}


final class NewsViewModel: Stateful, ObservableObject {
    
    @Published var news: [Post] = []
    
    @Published var loadingState: LoadingState = .idle
    @Published var error: String?
    
    let newsRepository: NewsRepositoryLogic
    var uploadRepository: UploadPhotoRepositoryLogic?
    
    var page: Int = 1
    var perPage: Int = 10
    var numberOfElements: Int = 0
    var isMore: Bool { numberOfElements > news.count }
    @Published var query: String = ""
    @Published var selectedUser: User?
    @Published var tags: [String] = []
    
    @Published var editingPost: Post?
    
    init(newsRepository: NewsRepositoryLogic, uploadRepository: UploadPhotoRepositoryLogic?) {
        self.newsRepository = newsRepository
        self.uploadRepository = uploadRepository
        $query
            .dropFirst()
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .flatMap({ [weak self, newsRepository] query in
                newsRepository.getNews(page: 1, perPage: self?.perPage ?? 10, keywords: query, author: self?.selectedUser?.name, tags: self?.tags) })
            .sink(receiveCompletion: receiveCompletion(_:), receiveValue: receiveNews(_:))
            .store(in: &subscriptions)
        $tags
            .dropFirst()
            .flatMap({ [weak self, newsRepository] tags in
                newsRepository.getNews(page: 1, perPage: self?.perPage ?? 10, keywords: self?.query, author: self?.selectedUser?.name, tags: tags) })
            .sink(receiveCompletion: receiveCompletion(_:), receiveValue: receiveNews(_:))
            .store(in: &subscriptions)
    }
    
    private var subscriptions: Set<AnyCancellable> = []
    
    private func receiveNews(_ data: DataNewsResponse) {
        numberOfElements = data.numberOfElements
        news = data.content
    }
    
    func getNews() {
        loadingState = .loading
        newsRepository.getNews(page: 1, perPage: perPage, keywords: query, author: selectedUser?.name, tags: tags)
            .sink(receiveCompletion: receiveCompletion(_:), receiveValue: receiveNews(_:))
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
        guard !title.isEmpty, !text.isEmpty else { error = "Can't save with empty fields"; return }
        guard let token = UserDefaults.standard.string(forKey: "token"), !token.isEmpty else { return }
        loadingState = .loading
        uploadRepository?.uploadPhoto(image)
            .flatMap({ [newsRepository] url in
                newsRepository.createPost(imageURL: url, title: title, text: text, tags: tags, token: token)
                    .map({ ($0, url) })
            })
            .tryMap( { [weak self] (id, url) -> Post in
                guard let user = self?.selectedUser else { throw AppError.internalError }
                return Post(id: id, userId: user.id, title: title, text: text, image: url, username: user.name, tags: tags)} )
            .sink(receiveCompletion: self.receiveCompletion(_:), receiveValue: { [weak self] post in
                self?.editingPost = nil
                self?.news.insert(post, at: 0)
            })
            .store(in: &subscriptions)
    }
    
    func updatePost(id: Int, image: UIImage, title: String, text: String, tags: [String]) {
        guard !title.isEmpty, !text.isEmpty else { error = "Can't save with empty fields"; return }
        guard let token = UserDefaults.standard.string(forKey: "token"), !token.isEmpty else { return }
        loadingState = .loading
        uploadRepository?.uploadPhoto(image)
            .flatMap({ [newsRepository] url in
                newsRepository.updatePost(id: id, imageURL: url, title: title, text: text, tags: tags, token: token)
                    .map({ ($0, url) })
            })
            .tryMap({ [weak self] (success, url) -> Post in
                guard let user = self?.selectedUser else { throw AppError.internalError }
                return Post(id: id, userId: user.id, title: title, text: text, image: url, username: user.name, tags: tags)
            })
            .sink(receiveCompletion: self.receiveCompletion(_:), receiveValue: { [weak self] post in
                guard let index = self?.news.firstIndex(of: post) else { return }
                self?.editingPost = nil
                self?.news[index] = post
            })
            .store(in: &subscriptions)
    }
    
    func deletePost(id: Int) {
        loadingState = .loading
        guard let token = UserDefaults.standard.string(forKey: "token") else { return }
        newsRepository.deletePost(id: id, token: token)
            .sink(receiveCompletion: receiveCompletion(_:), receiveValue: { success in
                if success {
                    self.editingPost = nil
                    self.news = self.news.filter({ $0.id != id })
                }
                else {
                    self.editingPost = nil
                    self.error = "Unknown error"
                    self.loadingState = .error
                }
            })
            .store(in: &subscriptions)
    }
}


