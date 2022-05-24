//
//  RegisterViewModel_Tests.swift
//  NewsTests
//
//  Created by dunice on 24.05.2022.
//

import XCTest

import XCTest
@testable import News

class RegisterViewModel_Tests: XCTestCase {
    
    func test_RegisterViewModel_register_succeeds() {
        // Given
        let appState = AppState()
        let vm = RegisterViewModel(appState: appState, registerRepository: RegisterRepositoryMock(), uploadRepository: UploadPhotoRepositoryMock())
        vm.selectedImage = UIImage(named: "image-placeholder")!
        vm.email = "bla@bla.com"
        vm.name = "Name"
        vm.password = "123456"
        vm.confirmPassword = "123456"
        // When
        vm.register()
        // Then
        XCTAssertNotNil(appState.user)
        XCTAssertNotNil(appState.token)
        XCTAssertEqual(appState.user?.email, vm.email)
        XCTAssertEqual(appState.user?.name, vm.name)
    }
    
    func test_RegisterViewModel_register_failsWithInvalidEmail() {
        // Given
        let appState = AppState()
        let vm = RegisterViewModel(appState: appState, registerRepository: RegisterRepositoryMock(), uploadRepository: UploadPhotoRepositoryMock())
        vm.selectedImage = UIImage(named: "image-placeholder")!
        vm.email = "blabla.com"
        vm.name = "Name"
        vm.password = "123456"
        vm.confirmPassword = "123456"
        // When
        vm.register()
        // Then
        XCTAssertNil(appState.user)
        XCTAssertEqual(appState.error, "Invalid email")
    }
    
    func test_RegisterViewModel_register_failsWithInvalidPassword() {
        // Given
        let appState = AppState()
        let vm = RegisterViewModel(appState: appState, registerRepository: RegisterRepositoryMock(), uploadRepository: UploadPhotoRepositoryMock())
        vm.selectedImage = UIImage(named: "image-placeholder")!
        vm.email = "bla@bla.com"
        vm.name = "Name"
        vm.password = "1234"
        vm.confirmPassword = "1234"
        // When
        vm.register()
        // Then
        XCTAssertNil(appState.user)
        XCTAssertEqual(appState.error, "Invalid password")
    }
    
    func test_RegisterViewModel_register_failsWithPasswordMismatch() {
        // Given
        let appState = AppState()
        let vm = RegisterViewModel(appState: appState, registerRepository: RegisterRepositoryMock(), uploadRepository: UploadPhotoRepositoryMock())
        vm.selectedImage = UIImage(named: "image-placeholder")!
        vm.email = "bla@bla.com"
        vm.name = "Name"
        vm.password = "1234567"
        vm.confirmPassword = "1234568"
        // When
        vm.register()
        // Then
        XCTAssertNil(appState.user)
        XCTAssertEqual(appState.error, "Password doesn't match confirmation")
    }
}
