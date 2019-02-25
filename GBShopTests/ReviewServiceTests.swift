//
//  ReviewServiceTests.swift
//  GBShopTests
//
//  Created by Olga Martyanova on 31/01/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import XCTest
@testable import GBShop

class ReviewServiceTests: XCTestCase {
    var networkService: NetworkServiceMock!
    var reviewService: ReviewService!
    let review = Review(idProduct: 111, idUser: 123, userName: "Иван", text: "Ноутбук")

    override func setUp() {
        super.setUp()
        networkService = NetworkServiceMock()
        reviewService = ReviewServiceImpl(
            baseUrl: URL(string: "https://yandex.ru")!,
            networkService: networkService
        )
    }

    override func tearDown() {
        networkService = nil
        reviewService = nil
        super.tearDown()
    }

    func testSuccessReview() {
        networkService.result = ReviewResponse(result: 1, userMessage: "Ok")
        var resultMessage: String?
        reviewService.addReview(review: review) { message in
            resultMessage = message
        }
        XCTAssertNotNil(resultMessage)
    }

    func testFailureReview() {
        var resultMessage: String?
        reviewService.addReview(review: review) { message in
            resultMessage = message
        }
        XCTAssertNil(resultMessage)
    }
}
