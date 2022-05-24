//
//  UserRepository_Tests.swift
//  NewsTests
//
//  Created by dunice on 24.05.2022.
//

import XCTest
import Combine
@testable import News

class UserRepository_Tests: XCTestCase {

    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - getUser
    
    func test_getUser_shouldSucceed() {
        // Given
        let token = AuthResponse.mock.token
        let repo = UserRepository()
        var user: User?
        // When
        let expectation = XCTestExpectation()
        repo.getUser(token: token)
            .sink { completion in
                switch completion {
                case .finished: expectation.fulfill()
                case .failure: XCTFail()
                }
            } receiveValue: { receivedUser in
                user = receivedUser
            }
            .store(in: &subscriptions)
        // Then
        wait(for: [expectation], timeout: 5.0)
        XCTAssertNotNil(user)
    }
    
    func test_getUser_shouldFailWithInvalidToken() {
        // Given
        let token = "some token"
        let repo = UserRepository()
        var user: User?
        // When
        let expectation = XCTestExpectation()
        repo.getUser(token: token)
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
    
    // MARK: - updateUser
    
    func test_updateUser_shouldSucceed() {
        // Given
        let token = AuthResponse.mock.token
        let repo = UserRepository()
        let avatar = AuthResponse.mock.avatar
        let name = "NewName"
        let email = "bla@bla.com"
        var user: User?
        // When
        let expectation = XCTestExpectation()
        repo.updateUser(token: token, avatar: avatar, email: email, name: name)
            .sink { completion in
                switch completion {
                case .finished: expectation.fulfill()
                case .failure: XCTFail()
                }
            } receiveValue: { receivedUser in
                user = receivedUser
                XCTAssertEqual(avatar, receivedUser.avatar)
                XCTAssertEqual(name, receivedUser.name)
                XCTAssertEqual(email, receivedUser.email)
            }
            .store(in: &subscriptions)
        // Then
        wait(for: [expectation], timeout: 5.0)
        XCTAssertNotNil(user)
    }
    
    func test_updateUser_shouldFailWithInvalidToken() {
        // Given
        let token = "some token"
        let repo = UserRepository()
        let avatar = AuthResponse.mock.avatar
        let name = "NewName"
        let email = "bla@bla.com"
        var user: User?
        // When
        let expectation = XCTestExpectation()
        repo.updateUser(token: token, avatar: avatar, email: email, name: name)
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
    
    func test_updateUser_shouldFailWithEmptyName() {
        // Given
        let token = AuthResponse.mock.token
        let repo = UserRepository()
        let avatar = AuthResponse.mock.avatar
        let name = ""
        let email = "bla@bla.com"
        var user: User?
        // When
        let expectation = XCTestExpectation()
        repo.updateUser(token: token, avatar: avatar, email: email, name: name)
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
    
    func test_updateUser_shouldFailWithInvalidEmail() {
        // Given
        let token = AuthResponse.mock.token
        let repo = UserRepository()
        let avatar = AuthResponse.mock.avatar
        let name = "NewName"
        let email = "blabla.com"
        var user: User?
        // When
        let expectation = XCTestExpectation()
        repo.updateUser(token: token, avatar: avatar, email: email, name: name)
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
    
    func test_updateUser_shouldFailWithEmptyEmail() {
        // Given
        let token = AuthResponse.mock.token
        let repo = UserRepository()
        let avatar = AuthResponse.mock.avatar
        let name = "NewName"
        let email = ""
        var user: User?
        // When
        let expectation = XCTestExpectation()
        repo.updateUser(token: token, avatar: avatar, email: email, name: name)
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
}
