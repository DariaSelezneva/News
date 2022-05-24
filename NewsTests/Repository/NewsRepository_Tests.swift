//
//  NewsRepository_Tests.swift
//  NewsTests
//
//  Created by dunice on 24.05.2022.
//

import XCTest
import Combine
@testable import News

class NewsRepository_Tests: XCTestCase {
    
    private var subscriptions = Set<AnyCancellable>()

    // MARK: - getNews
    
    func test_NewsRepository_getNews_withoutQuery_shouldReceiveData() {
        // Given
        let repo = NewsRepository()
        var posts: [Post]?
        // When
        let expectation = XCTestExpectation()
        repo.getNews(page: 1, perPage: 10)
            .sink { completion in
                switch completion {
                case .finished: expectation.fulfill()
                case .failure: XCTFail()
                }
            } receiveValue: { response in
                posts = response.content
                XCTAssertEqual(response.content.count, response.numberOfElements > 10 ? 10 : response.numberOfElements)
            }
            .store(in: &subscriptions)
        // Then
        wait(for: [expectation], timeout: 5.0)
        XCTAssertNotNil(posts)
    }
    
    func test_NewsRepository_getNews_withoutQuery_shouldFail_withInvalidPage() {
        // Given
        let repo = NewsRepository()
        var posts: [Post]?
        // When
        let expectation = XCTestExpectation()
        repo.getNews(page: -1, perPage: 10)
            .sink { completion in
                switch completion {
                case .finished: XCTFail()
                case .failure: expectation.fulfill()
                }
            } receiveValue: { response in
                posts = response.content
            }
            .store(in: &subscriptions)
        // Then
        wait(for: [expectation], timeout: 5.0)
        XCTAssertNil(posts)
    }
    
    // MARK: - GetUser
    
    func test_NewsRepository_getUser_shouldReceiveData() {
        // Given
        let id = "23817669-18cc-4402-9707-7a49f93cbe25" // valid id
        let repo = NewsRepository()
        var user: User?
        // When
        let expectation = XCTestExpectation()
        repo.getUser(id: id)
            .sink { completion in
                switch completion {
                case .finished: expectation.fulfill()
                case .failure: XCTFail()
                }
            } receiveValue: { receivedUser in
                user = receivedUser
                XCTAssertEqual(receivedUser.id, id)
            }
            .store(in: &subscriptions)
        // Then
        wait(for: [expectation], timeout: 5.0)
        XCTAssertNotNil(user)
    }
    
    func test_NewsRepository_getUser_shouldFailWithInvalidID() {
        // Given
        let id = "some id" // invalid id
        let repo = NewsRepository()
        var user: User?
        // When
        let expectation = XCTestExpectation()
        repo.getUser(id: id)
            .sink { completion in
                switch completion {
                case .finished: XCTFail()
                case .failure: expectation.fulfill()
                }
            } receiveValue: { receivedUser in
                user = receivedUser
            }
            .store(in: &subscriptions)
        // Then
        wait(for: [expectation], timeout: 5.0)
        XCTAssertNil(user)
    }
    
    // MARK: - createPost
    
    func test_NewsRepository_createPost_shouldSucceed() {
        // Given
        var id: Int?
        let repo = NewsRepository()
        let post = PostCreationBody(image: "https://news-feed.dunice-testing.com/api/v1/file/693d86bf-fedd-47e8-8f00-332780ab46b8.", title: "Title", description: "Text", tags: ["tag", "tag2"])
        let token = AuthResponse.mock.token
        // When
        let expectation = XCTestExpectation()
        repo.createPost(imageURL: post.image, title: post.title, text: post.description, tags: post.tags, token: token)
            .sink { completion in
                switch completion {
                case .finished: expectation.fulfill()
                case .failure: XCTFail()
                }
            } receiveValue: { receivedID in
                id = receivedID
                XCTAssertEqual(receivedID, id)
            }
            .store(in: &subscriptions)
        // Then
        wait(for: [expectation], timeout: 5.0)
        XCTAssertNotNil(id)
    }
    
    func test_NewsRepository_createPost_shouldFailWithInvalidToken() {
        // Given
        var id: Int?
        let repo = NewsRepository()
        let post = PostCreationBody(image: "https://news-feed.dunice-testing.com/api/v1/file/693d86bf-fedd-47e8-8f00-332780ab46b8.", title: "Title", description: "Text", tags: ["tag", "tag2"])
        let token = "some token"
        // When
        let expectation = XCTestExpectation()
        repo.createPost(imageURL: post.image, title: post.title, text: post.description, tags: post.tags, token: token)
            .sink { completion in
                switch completion {
                case .finished: XCTFail()
                case .failure: expectation.fulfill()
                }
            } receiveValue: { receivedID in
                id = receivedID
            }
            .store(in: &subscriptions)
        // Then
        wait(for: [expectation], timeout: 5.0)
        XCTAssertNil(id)
    }
    
    func test_NewsRepository_createPost_shouldFailWithInvalidImage() {
        // Given
        var id: Int?
        let repo = NewsRepository()
        let post = PostCreationBody(image: "", title: "Title", description: "Text", tags: ["tag", "tag2"])
        let token = AuthResponse.mock.token
        // When
        let expectation = XCTestExpectation()
        repo.createPost(imageURL: post.image, title: post.title, text: post.description, tags: post.tags, token: token)
            .sink { completion in
                switch completion {
                case .finished: XCTFail()
                case .failure: expectation.fulfill()
                }
            } receiveValue: { receivedID in
                id = receivedID
            }
            .store(in: &subscriptions)
        // Then
        wait(for: [expectation], timeout: 5.0)
        XCTAssertNil(id)
    }
    
    func test_NewsRepository_createPost_shouldFailWithEmptyTitle() {
        // Given
        var id: Int?
        let repo = NewsRepository()
        let post = PostCreationBody(image: "https://news-feed.dunice-testing.com/api/v1/file/693d86bf-fedd-47e8-8f00-332780ab46b8.", title: "", description: "Text", tags: ["tag", "tag2"])
        let token = AuthResponse.mock.token
        // When
        let expectation = XCTestExpectation()
        repo.createPost(imageURL: post.image, title: post.title, text: post.description, tags: post.tags, token: token)
            .sink { completion in
                switch completion {
                case .finished: XCTFail()
                case .failure: expectation.fulfill()
                }
            } receiveValue: { receivedID in
                id = receivedID
            }
            .store(in: &subscriptions)
        // Then
        wait(for: [expectation], timeout: 5.0)
        XCTAssertNil(id)
    }
    
    func test_NewsRepository_createPost_shouldFailWithEmptyText() {
        // Given
        var id: Int?
        let repo = NewsRepository()
        let post = PostCreationBody(image: "https://news-feed.dunice-testing.com/api/v1/file/693d86bf-fedd-47e8-8f00-332780ab46b8.", title: "Title", description: "", tags: ["tag", "tag2"])
        let token = AuthResponse.mock.token
        // When
        let expectation = XCTestExpectation()
        repo.createPost(imageURL: post.image, title: post.title, text: post.description, tags: post.tags, token: token)
            .sink { completion in
                switch completion {
                case .finished: XCTFail()
                case .failure: expectation.fulfill()
                }
            } receiveValue: { receivedID in
                id = receivedID
            }
            .store(in: &subscriptions)
        // Then
        wait(for: [expectation], timeout: 5.0)
        XCTAssertNil(id)
    }
    
    func test_NewsRepository_createPost_shouldSucceedWithEmptyTags() {
        // Given
        var id: Int?
        let repo = NewsRepository()
        let post = PostCreationBody(image: "https://news-feed.dunice-testing.com/api/v1/file/693d86bf-fedd-47e8-8f00-332780ab46b8.", title: "Title", description: "Text", tags: [])
        let token = AuthResponse.mock.token
        // When
        let expectation = XCTestExpectation()
        repo.createPost(imageURL: post.image, title: post.title, text: post.description, tags: post.tags, token: token)
            .sink { completion in
                switch completion {
                case .finished: expectation.fulfill()
                case .failure: XCTFail()
                }
            } receiveValue: { receivedID in
                id = receivedID
                XCTAssertEqual(receivedID, id)
            }
            .store(in: &subscriptions)
        // Then
        wait(for: [expectation], timeout: 5.0)
        XCTAssertNotNil(id)
    }
    
    // MARK: - updatePost
    
    func test_NewsRepository_updatePost_shouldSucceed() {
        // Given
        let id = 3802 // use actual post id for user with given token
        let repo = NewsRepository()
        let post = PostCreationBody(image: "https://news-feed.dunice-testing.com/api/v1/file/693d86bf-fedd-47e8-8f00-332780ab46b8.", title: "New title", description: "New text", tags: [])
        let token = AuthResponse.mock.token
        // When
        let expectation = XCTestExpectation()
        repo.updatePost(id: id, imageURL: post.image, title: post.title, text: post.description, tags: post.tags, token: token)
            .sink { completion in
                switch completion {
                case .finished: expectation.fulfill()
                case .failure: XCTFail()
                }
            } receiveValue: { success in
                XCTAssertEqual(success, true)
            }
            .store(in: &subscriptions)
        // Then
        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_NewsRepository_updatePost_shouldFailWithInvalidID() {
        // Given
        let id = -1
        let repo = NewsRepository()
        let post = PostCreationBody(image: "https://news-feed.dunice-testing.com/api/v1/file/693d86bf-fedd-47e8-8f00-332780ab46b8.", title: "New title", description: "New text", tags: [])
        let token = AuthResponse.mock.token
        // When
        let expectation = XCTestExpectation()
        repo.updatePost(id: id, imageURL: post.image, title: post.title, text: post.description, tags: post.tags, token: token)
            .sink { completion in
                switch completion {
                case .finished: XCTFail()
                case .failure: expectation.fulfill()
                }
            } receiveValue: { success in
                XCTAssertEqual(success, false)
            }
            .store(in: &subscriptions)
        // Then
        wait(for: [expectation], timeout: 5.0)
    }
    
    // MARK: - deletePost
    
    func test_NewsRepository_deletePost_shouldSucceed() {
        // Given
        let id = 3802 // use actual post id on every test
        let repo = NewsRepository()
        let token = AuthResponse.mock.token
        // When
        let expectation = XCTestExpectation()
        repo.deletePost(id: id, token: token)
            .sink { completion in
                switch completion {
                case .finished: expectation.fulfill()
                case .failure: XCTFail()
                }
            } receiveValue: { success in
                XCTAssertEqual(success, true)
            }
            .store(in: &subscriptions)
        // Then
        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_NewsRepository_deletePost_shouldFailWithInvalidID() {
        // Given
        let id = -1
        let repo = NewsRepository()
        let token = AuthResponse.mock.token
        // When
        let expectation = XCTestExpectation()
        repo.deletePost(id: id, token: token)
            .sink { completion in
                switch completion {
                case .finished: XCTFail()
                case .failure: expectation.fulfill()
                }
            } receiveValue: { success in
                XCTAssertEqual(success, false)
            }
            .store(in: &subscriptions)
        // Then
        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_NewsRepository_deletePost_shouldFailWithInvalidToken() {
        // Given
        let id = 3802
        let repo = NewsRepository()
        let token = "some token"
        // When
        let expectation = XCTestExpectation()
        repo.deletePost(id: id, token: token)
            .sink { completion in
                switch completion {
                case .finished: XCTFail()
                case .failure: expectation.fulfill()
                }
            } receiveValue: { success in
                XCTAssertEqual(success, false)
            }
            .store(in: &subscriptions)
        // Then
        wait(for: [expectation], timeout: 5.0)
    }
}
