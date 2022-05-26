//
//  UserView_UITests.swift
//  NewsUITests
//
//  Created by dunice on 26.05.2022.
//

import XCTest

class UserView_UITests: XCTestCase, TypingTester {
    
    var app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
        app.tabBars["Tab Bar"].buttons["Profile"].tap()
        if app.buttons["LoginButton"].waitForExistence(timeout: 1.0) {
            app.textFields["LoginEmailTextField"].tap()
            type("bla@bla.com")
            app.secureTextFields["SecureTextField"].tap()
            type("123456")
            app.buttons["LoginButton"].tap()
        }
    }

    override func tearDownWithError() throws {
    }
    
    func test_UserView_showsEditingUser() {
        app.buttons["EditProfileButton"].tap()
        XCTAssertTrue(app.textFields["Name"].exists)
        XCTAssertTrue(app.textFields["Email"].exists)
    }
    
    func test_UserView_logsOut() {
        app.buttons["EditProfileButton"].tap()
        app.buttons["LogoutButton"].tap()
        let logoutAlertButton = app.alerts["Do you want to log out?"].scrollViews.otherElements.buttons["Logout"]
        guard logoutAlertButton.waitForExistence(timeout: 1.0) else { XCTFail(); return }
        logoutAlertButton.tap()
        XCTAssertTrue(app.secureTextFields["Password"].waitForExistence(timeout: 2.0))
    }
}
