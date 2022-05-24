//
//  RegisterRepository_Tests.swift
//  NewsTests
//
//  Created by dunice on 24.05.2022.
//

import XCTest
import Combine
@testable import News

class RegisterRepository_Tests: XCTestCase {
    
    private var subscriptions = Set<AnyCancellable>()

    func test_RegisterRepository_shouldRegister() {
        //Given
        let avatar = "https://news-feed.dunice-testing.com/api/v1/file/693d86bf-fedd-47e8-8f00-332780ab46b8."
        let email = "email2@bla.com" // change email on every test
        let name = "NewUser"
        let password = "123456"
        let repo = RegisterRepository()
        // When
        var token: String?
        var id: String?
        let expectation = XCTestExpectation()
        repo.register(avatar: avatar, email: email, name: name, password: password)
            .sink { completion in
                switch completion {
                case .finished: expectation.fulfill()
                case .failure: XCTFail()
                }
            } receiveValue: { authResponse in
                token = authResponse.token
                id = authResponse.id
                XCTAssertEqual(authResponse.avatar, avatar)
                XCTAssertEqual(authResponse.email, email)
                XCTAssertEqual(authResponse.name, name)
            }
            .store(in: &subscriptions)
        wait(for: [expectation], timeout: 5.0)
        XCTAssertNotNil(token)
        XCTAssertNotNil(id)
    }
    
    func test_RegisterRepository_shouldCompleteWithFailure_WithExistingEmail() {
        //Given
        let avatar = "https://news-feed.dunice-testing.com/api/v1/file/693d86bf-fedd-47e8-8f00-332780ab46b8."
        let email = "email@bla.com" // existing email
        let name = "NewUser"
        let password = "123456"
        let repo = RegisterRepository()
        // When
        var token: String?
        var id: String?
        let expectation = XCTestExpectation()
        repo.register(avatar: avatar, email: email, name: name, password: password)
            .sink { completion in
                switch completion {
                case .finished: XCTFail()
                case .failure: expectation.fulfill()
                }
            } receiveValue: { authResponse in
                token = authResponse.token
                id = authResponse.id
            }
            .store(in: &subscriptions)
        // Then
        wait(for: [expectation], timeout: 5.0)
        XCTAssertNil(token)
        XCTAssertNil(id)
    }
    
    func test_RegisterRepository_shouldCompleteWithFailure_withInvalidEmail() {
        //Given
        let avatar = "https://news-feed.dunice-testing.com/api/v1/file/693d86bf-fedd-47e8-8f00-332780ab46b8."
        let email = "email6bla.com" // invalid email
        let name = "NewUser"
        let password = "123456"
        let repo = RegisterRepository()
        // When
        var token: String?
        var id: String?
        let expectation = XCTestExpectation()
        repo.register(avatar: avatar, email: email, name: name, password: password)
            .sink { completion in
                switch completion {
                case .finished: XCTFail()
                case .failure: expectation.fulfill()
                }
            } receiveValue: { authResponse in
                token = authResponse.token
                id = authResponse.id
            }
            .store(in: &subscriptions)
        // Then
        wait(for: [expectation], timeout: 5.0)
        XCTAssertNil(token)
        XCTAssertNil(id)
    }
}
