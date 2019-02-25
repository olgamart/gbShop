//
//  RemoveReviewServiceTests.swift
//  GBShopTests
//
//  Created by Olga Martyanova on 31/01/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import XCTest
@testable import GBShop

class RemoveReviewServiceTests: XCTestCase {
    var networkService: NetworkServiceMock!
    var removeReviewService: RemoveReviewService!

    override func setUp() {
        super.setUp()

        networkService = NetworkServiceMock()
        removeReviewService = RemoveReviewServiceImpl(
            baseUrl: URL(string: "https://yandex.ru")!,
            networkService: networkService
        )
    }

    override func tearDown() {
        networkService = nil
        removeReviewService = nil
        super.tearDown()
    }

    func testSuccessRemoveReview() {
        networkService.result = RemoveReviewResponse(result: 1)
        var resultTest: Int?
        removeReviewService.removeReview(idComment: 123) { result in
            resultTest = result
        }
        XCTAssertEqual(resultTest, 1)
    }

    func testFailureRemoveReview() {
        var resultTest: Int?
        removeReviewService.removeReview(idComment: 123) { result in
            resultTest = result
        }
        XCTAssertNotEqual(resultTest, 1)
    }
}
