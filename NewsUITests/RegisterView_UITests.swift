//
//  RegisterView_UITests.swift
//  NewsUITests
//
//  Created by dunice on 26.05.2022.
//

import XCTest
@testable import News

class RegisterView_UITests: XCTestCase, TypingTester {
    
    var app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
        app.tabBars["Tab Bar"].buttons["Profile"].tap()
        if app.buttons["EditProfileButton"].waitForExistence(timeout: 1.0) {
            app.buttons["EditProfileButton"].tap()
            app.buttons["LogoutButton"].tap()
            let logoutAlertButton = app.alerts["Do you want to log out?"].scrollViews.otherElements.buttons["Logout"]
            guard logoutAlertButton.waitForExistence(timeout: 1.0) else { XCTFail(); return }
            logoutAlertButton.tap()
        }
        app.buttons["ShowRegistrationButton"].tap()
    }
    
    override func tearDownWithError() throws {
    }
    
    func test_RegisterView_shouldEnableButtonWhenTextfieldsNotEmpty() {
        let registerButton = app.buttons["RegisterButton"]
        XCTAssertFalse(registerButton.isEnabled)
        app.textFields["RegisterNameTextField"].tap()
        type("Name")
        XCTAssertFalse(registerButton.isEnabled)
        app.textFields["RegisterEmailTextField"].tap()
        type("email@bla.com")
        XCTAssertFalse(registerButton.isEnabled)
        app.secureTextFields["Password"].tap()
        type("password")
        XCTAssertFalse(registerButton.isEnabled)
        app.secureTextFields["Confirm password"].tap()
        type("pass")
        XCTAssertFalse(registerButton.isEnabled)
        app.secureTextFields["Confirm password"].tap()
        type("password")
        XCTAssertTrue(registerButton.isEnabled)
    }
    
    func test_RegisterView_TogglesPhotoSelection() {
        app.buttons["PhotoPickerButton"].tap()
        XCTAssertTrue(app.buttons["CameraButton"].exists)
        XCTAssertTrue(app.buttons["PhotoLibraryButton"].exists)
        app.buttons["PhotoPickerButton"].tap()
        XCTAssertFalse(app.buttons["CameraButton"].exists)
        XCTAssertFalse(app.buttons["PhotoLibraryButton"].exists)
    }
}

