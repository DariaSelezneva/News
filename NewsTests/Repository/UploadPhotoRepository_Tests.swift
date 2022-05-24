//
//  UploadPhotoRepository_Tests.swift
//  NewsTests
//
//  Created by dunice on 24.05.2022.
//

import XCTest
import Combine
@testable import News

class UploadPhotoRepository_Tests: XCTestCase {
    
    private var subscriptions = Set<AnyCancellable>()
    
    func test_UploadPhotoRepository_shouldUpload() {
        // Given
        let image = UIImage(named: "image-placeholder")!
        let repo = UploadPhotoRepository()
        var url: String?
        // When
        let expectation = XCTestExpectation()
        repo.uploadPhoto(image)
            .sink { completion in
                switch completion {
                case .finished: expectation.fulfill()
                case .failure: XCTFail()
                }
            } receiveValue: { receivedURL in
                url = receivedURL
            }
            .store(in: &subscriptions)
        // Then
        wait(for: [expectation], timeout: 5.0)
        XCTAssertNotNil(url)
    }
}
