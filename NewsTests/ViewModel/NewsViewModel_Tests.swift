//
//  NewsViewModel_Tests.swift
//  NewsTests
//
//  Created by dunice on 24.05.2022.
//

import XCTest
@testable import News

class NewsViewModel_Tests: XCTestCase {

    func test_NewsViewModel_getNews_receivesData() {
        // Given
        let vm = NewsViewModel(newsRepository: NewsRepositoryMock(), uploadRepository: nil)
        let postsMock = Post.mock
        // When
        vm.getNews()
        // Then
        XCTAssertFalse(vm.news.isEmpty)
        XCTAssertEqual(vm.numberOfElements, postsMock.count)
    }
    
    func test_NewsViewModel_getUser_receivesData() {
        // Given
        let vm = NewsViewModel(newsRepository: NewsRepositoryMock(), uploadRepository: nil)
        let userMock = User.mock
        // When
        vm.getUser(id: userMock.id)
        // Then
        XCTAssertNotNil(vm.selectedUser)
        XCTAssertEqual(vm.selectedUser?.id, userMock.id)
    }
    
    func test_NewsViewModel_createsPost() {
        // Given
        let vm = NewsViewModel(newsRepository: NewsRepositoryMock(), uploadRepository: UploadPhotoRepositoryMock())
        vm.selectedUser = User.mock
        UserDefaults.standard.set(AuthResponse.mock.token, forKey: "token")
        // When
        vm.createPost(image: UIImage(), title: "Title", text: "Text", tags: ["tag"])
        // Then
        XCTAssertFalse(vm.news.isEmpty)
        XCTAssertEqual(vm.news.first?.text, "Text")
        XCTAssertEqual(vm.news.first?.userId, User.mock.id)
    }
    
    func test_NewsViewModel_postCreationFailsWithEmptyFields() {
        // Given
        let vm = NewsViewModel(newsRepository: NewsRepositoryMock(), uploadRepository: UploadPhotoRepositoryMock())
        vm.selectedUser = User.mock
        UserDefaults.standard.set(AuthResponse.mock.token, forKey: "token")
        // When
        vm.createPost(image: UIImage(), title: "", text: "Text", tags: ["tag"])
        // Then
        XCTAssertTrue(vm.news.isEmpty)
        XCTAssertNotNil(vm.error)
    }
    
    func test_NewsViewModel_updatesPost() {
        // Given
        let vm = NewsViewModel(newsRepository: NewsRepositoryMock(), uploadRepository: UploadPhotoRepositoryMock())
        vm.news = Post.mock
        let post = vm.news.last!
        vm.selectedUser = User.mock
        UserDefaults.standard.set(AuthResponse.mock.token, forKey: "token")
        // When
        vm.updatePost(id: post.id, image: UIImage(), title: "NewTitle", text: "NewText", tags: [])
        // Then
        XCTAssertEqual(vm.news.last!.text, "NewText")
        XCTAssertTrue(vm.news.last!.tags.isEmpty)
    }
    
    func test_NewsViewModel_postUpdateFailsWithEmptyFields() {
        // Given
        let vm = NewsViewModel(newsRepository: NewsRepositoryMock(), uploadRepository: UploadPhotoRepositoryMock())
        vm.news = Post.mock
        let post = vm.news.last!
        vm.selectedUser = User.mock
        UserDefaults.standard.set(AuthResponse.mock.token, forKey: "token")
        // When
        vm.updatePost(id: post.id, image: UIImage(), title: "NewTitle", text: "", tags: [])
        // Then
        XCTAssertNotEqual(vm.news.last!.title, "NewTitle")
        XCTAssertNotNil(vm.error)
    }
    
    func test_NewsViewModel_deletesPost() {
        // Given
        let vm = NewsViewModel(newsRepository: NewsRepositoryMock(), uploadRepository: UploadPhotoRepositoryMock())
        vm.news = Post.mock
        let post = Post.mock.last!
        vm.selectedUser = User.mock
        UserDefaults.standard.set(AuthResponse.mock.token, forKey: "token")
        // When
        vm.deletePost(id: post.id)
        // Then
        XCTAssertEqual(vm.news.count, Post.mock.count - 1)
        XCTAssertNil(vm.news.filter{ $0.id == post.id}.first)
    }
}
