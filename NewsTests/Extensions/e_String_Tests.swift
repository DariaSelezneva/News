//
//  e_String_Tests.swift
//  NewsTests
//
//  Created by dunice on 24.05.2022.
//

import XCTest
import Combine
@testable import News

class e_String_Tests: XCTestCase {

    // MARK: - tags
    func test_String_tags_succeeds() {
        
        let string = "Some #string with some #tags"
        let tags = string.tags()
        XCTAssertEqual(tags, ["string", "tags"])
    }
    
    func test_String_tags_succeedsWithoutSpaces() {
        
        let string = "Some #string with some #tags#tag"
        let tags = string.tags()
        XCTAssertEqual(tags.count, 3)
    }
    
    func test_String_tags_succeedsWithMultipleSharps() {
        
        let string = "Some ##string"
        let tags = string.tags()
        XCTAssertEqual(tags, ["string"])
    }
    
    func test_String_tags_failsWithDisallowedSymbols() {
        
        let string = "Some #$tring with some #t@gs"
        let tags = string.tags()
        XCTAssertNotEqual(tags, ["string", "tags"])
    }
    
    func test_String_tags_failsWithEmptyTags() {
        
        let string = "Some #string with some #"
        let tags = string.tags()
        XCTAssertNotEqual(tags.count, 2)
    }
    
    // MARK: - withoutExtraSpaces
    
    func test_withoutExtraSpaces_succeeds() {
        let string = "Some      string with some      "
        let trimmedString = string.withoutExtraSpaces()
        XCTAssertEqual(trimmedString, "Some string with some")
    }
    
    // MARK: - isValidEmail
    
    func test_isValidEmail_succeeds() {
        let string = "example@bla.com"
        let isValid = string.isValidEmail
        XCTAssertTrue(isValid)
    }
    
    func test_isValidEmail_failsWithoutAt() {
        let string = "examplebla.com"
        let isValid = string.isValidEmail
        XCTAssertFalse(isValid)
    }
    
    func test_isValidEmail_failsWhenBeginsWithAt() {
        let string = "@examplebla.com"
        let isValid = string.isValidEmail
        XCTAssertFalse(isValid)
    }
    
    func test_isValidEmail_failsWhenEmpty() {
        let string = ""
        let isValid = string.isValidEmail
        XCTAssertFalse(isValid)
    }
    
    func test_isValidEmail_failsWhenWithoutDot() {
        let string = "example@blacom"
        let isValid = string.isValidEmail
        XCTAssertFalse(isValid)
    }
    
    func test_isValidEmail_failsWithDotAfterAt() {
        let string = "example@.blacom"
        let isValid = string.isValidEmail
        XCTAssertFalse(isValid)
    }
    
    func test_isValidEmail_failsWithDisallowedSymbols() {
        let string = "e$ample@bla.com"
        let isValid = string.isValidEmail
        XCTAssertFalse(isValid)
    }
    
    // MARK: - isValidPassword
    
    func test_isValidPassword_succeeds() {
        let string = "dghfjfg132243"
        let isValid = string.isValidPassword
        XCTAssertTrue(isValid)
    }
    
    func test_isValidPassword_failsLessThanSixSymbols() {
        let string = "dghfj"
        let isValid = string.isValidPassword
        XCTAssertFalse(isValid)
    }
    
    func test_isValidPassword_failsWithDisallowedSymbols() {
        let string = "dghf#j"
        let isValid = string.isValidPassword
        XCTAssertFalse(isValid)
    }
}
