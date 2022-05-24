//
//  LoginViewModel_Tests.swift
//  NewsTests
//
//  Created by dunice on 24.05.2022.
//

import XCTest
import Combine
@testable import News

class LoginViewModel_Tests: XCTestCase {
    
    func test_LoginViewModel_login_succeeds() {
        // Given
        let appState = AppState()
        let vm = LoginViewModel(appState: appState, repository: LoginRepositoryMock())
        vm.email = "bla@bla.com"
        vm.password = "123456"
        // When
        vm.login()
        // Then
        XCTAssertNotNil(appState.user)
        XCTAssertNotNil(appState.token)
        XCTAssertEqual(appState.user?.email, vm.email)
    }
    
    func test_LoginViewModel_login_failsWithInvalidEmail() {
        // Given
        let appState = AppState()
        let vm = LoginViewModel(appState: appState, repository: LoginRepositoryMock())
        vm.email = "blabla.com"
        vm.password = "123456"
        // When
        vm.login()
        // Then
        XCTAssertNil(appState.user)
        XCTAssertEqual(appState.error, "Invalid email")
    }
    
    func test_LoginViewModel_login_failsWithInvalidPassword() {
        // Given
        let appState = AppState()
        let vm = LoginViewModel(appState: appState, repository: LoginRepositoryMock())
        vm.email = "bla@bla.com"
        vm.password = "12345"
        // When
        vm.login()
        // Then
        XCTAssertNil(appState.user)
        XCTAssertEqual(appState.error, "Invalid password")
    }
}
