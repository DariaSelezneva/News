//
//  LoginRepository_Tests.swift
//  NewsTests
//
//  Created by dunice on 24.05.2022.
//

import XCTest
import Combine
@testable import News

class LoginRepository_Tests: XCTestCase {
    
    private var subscriptions = Set<AnyCancellable>()

    func test_LoginRepository_shouldLogin() {
        // Given
        let email = "bla@bla.com"
        let password = "123456"
        let repo = LoginRepository()
        // When
        let expectation = XCTestExpectation()
        var token: String?
        var receivedEmail: String?
        repo.login(email: email, password: password)
            .sink { completion in
                switch completion {
                case .finished: expectation.fulfill()
                case .failure: XCTFail()
                }
            } receiveValue: { authResponse in
                token = authResponse.token
                receivedEmail = authResponse.email
            }
            .store(in: &subscriptions)

        //Then
        wait(for: [expectation], timeout: 5.0)
        XCTAssertNotNil(token)
        XCTAssertEqual(email, receivedEmail)
    }
    
    func test_LoginRepository_login_shouldFail_withInvalidEmail() {
        // Given
        let email = "blabla.com"
        let password = "123456"
        let repo = LoginRepository()
        // When
        let expectation = XCTestExpectation()
        repo.login(email: email, password: password)
            .sink { completion in
                switch completion {
                case .finished: XCTFail()
                case .failure: expectation.fulfill()
                }
            } receiveValue: { _ in }
            .store(in: &subscriptions)
        // Then
        wait(for: [expectation], timeout: 5.0)
    }
}
