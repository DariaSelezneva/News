//
//  UserViewModel_Tests.swift
//  NewsTests
//
//  Created by dunice on 24.05.2022.
//

import XCTest
@testable import News

class UserViewModel_Tests: XCTestCase {

    func test_UserViewModel_shouldGetUser() {
        // Given
        let appState = AppState()
        let vm = UserViewModel(appState: appState, userRepository: UserRepositoryMock(), uploadRepository: UploadPhotoRepositoryMock())
        UserDefaults.standard.set(AuthResponse.mock.token, forKey: "token")
        // When
        vm.getUser()
        // Then
        XCTAssertNotNil(appState.user)
    }
    
    func test_UserViewModel_shouldUpdateUser() {
        // Given
        let appState = AppState()
        let vm = UserViewModel(appState: appState, userRepository: UserRepositoryMock(), uploadRepository: UploadPhotoRepositoryMock())
        UserDefaults.standard.set(AuthResponse.mock.token, forKey: "token")
        appState.user = User.mock
        // When
        vm.updateUser(avatar: UIImage(), name: "NewName", email: "newEmail@bla.com")
        // Then
        XCTAssertEqual(appState.user?.name, "NewName")
        XCTAssertEqual(appState.user?.email, "newEmail@bla.com")
    }
    
    func test_UserViewModel_userUpdateFailsWithEmptyFields() {
        // Given
        let appState = AppState()
        let vm = UserViewModel(appState: appState, userRepository: UserRepositoryMock(), uploadRepository: UploadPhotoRepositoryMock())
        UserDefaults.standard.set(AuthResponse.mock.token, forKey: "token")
        appState.user = User.mock
        // When
        vm.updateUser(avatar: UIImage(), name: "", email: "newEmail@bla.com")
        // Then
        XCTAssertNotEqual(appState.user?.email, "newEmail@bla.com")
        XCTAssertNotNil(appState.error)
        XCTAssertEqual(appState.error, "Can't save with empty fields")
    }
    
    func test_UserViewModel_userUpdateFailsWithInvalidEmail() {
        // Given
        let appState = AppState()
        let vm = UserViewModel(appState: appState, userRepository: UserRepositoryMock(), uploadRepository: UploadPhotoRepositoryMock())
        UserDefaults.standard.set(AuthResponse.mock.token, forKey: "token")
        appState.user = User.mock
        // When
        vm.updateUser(avatar: UIImage(), name: "NewName", email: "newEmailbla.com")
        // Then
        XCTAssertNotEqual(appState.user?.name, "NewName")
        XCTAssertNotNil(appState.error)
        XCTAssertEqual(appState.error, "Invalid email")
    }
}
