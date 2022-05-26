//
//  LoginView_UITests.swift
//  NewsUITests
//
//  Created by dunice on 04.05.2022.
//

import XCTest
@testable import News

class LoginView_UITests: XCTestCase, TypingTester {
    
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
    }

    override func tearDownWithError() throws {
    }
    
    func test_LoginView_shouldShowRegisterScreen() {
        app.buttons["ShowRegistrationButton"].tap()
        let registerButton = app.buttons["RegisterButton"]
        XCTAssertTrue(registerButton.exists)
    }
    
    func test_LoginView_shouldEnableButtonWhenTextfieldsNotEmpty() {
        let loginButton = app.buttons["LoginButton"]
        XCTAssertFalse(loginButton.isEnabled)
        app.textFields["LoginEmailTextField"].tap()
        type("a")
        XCTAssertFalse(loginButton.isEnabled)
        app.secureTextFields["SecureTextField"].tap()
        type("f")
        XCTAssertTrue(loginButton.isEnabled)
    }
    
    func test_LoginView_shouldSwitchPasswordTextFields() {
        let eyeButton = app.buttons["eyeButton"]
        XCTAssertTrue(eyeButton.exists)
        eyeButton.tap()
        XCTAssertTrue(app.textFields["Password"].exists)
        eyeButton.tap()
        XCTAssertTrue(app.secureTextFields["SecureTextField"].exists)
    }
}
