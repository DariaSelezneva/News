//
//  p_TypingTester.swift
//  NewsUITests
//
//  Created by dunice on 26.05.2022.
//

import XCTest
@testable import News

protocol TypingTester {
    var app: XCUIApplication { get set }
    func type(_ string: String)
}

extension TypingTester {
    func type(_ string: String) {
        let shiftKey = app.buttons["shift"]
        for character in string {
            if !app.keys[String(character)].waitForExistence(timeout: 1.0) {
                shiftKey.tap()
                if !app.keys[String(character)].waitForExistence(timeout: 1.0) {
                    app.keys["more"].tap()
                    if !app.keys[String(character)].waitForExistence(timeout: 1.0) {
                        shiftKey.tap()
                    }
                }
            }
            app.keys[String(character)].tap()
        }
        let returnButton = app.buttons["Return"]
        returnButton.tap()
    }
}
