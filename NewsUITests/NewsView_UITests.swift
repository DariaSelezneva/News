//
//  NewsView_UITests.swift
//  NewsUITests
//
//  Created by dunice on 26.05.2022.
//

import XCTest

class NewsView_UITests: XCTestCase, TypingTester {
    
    var app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    override func tearDownWithError() throws {
    }

    func test_NewsView_selectsUser() {
        
        let elementsQuery = app.scrollViews.otherElements
        let nameButton = elementsQuery.buttons["50e227"]
        nameButton.tap()
        let closeButton = app.buttons["multiply"]
        let nameText = app.staticTexts["50e227"]
        XCTAssertTrue(nameText.exists)
        XCTAssertTrue(closeButton.exists)
        closeButton.tap()
        XCTAssertFalse(nameText.exists)
        XCTAssertFalse(closeButton.exists)
    }
    
    func test_NewsView_deletesTextInTextfield() {
        
        app.textFields["Search..."].tap()
        type("a")
        let clearButton = app.buttons["multiply"]
        XCTAssertTrue(clearButton.exists)
        clearButton.tap()
        XCTAssertTrue(app.images["Search"].exists)
    }
}
