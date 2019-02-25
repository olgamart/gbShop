//
//  ReviewsListServiceTests.swift
//  GBShopTests
//
//  Created by Olga Martyanova on 31/01/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import XCTest
@testable import GBShop
var networkService: NetworkServiceMock!
var reviewsListService: ReviewsListService!

class ReviewsListServiceTests: XCTestCase {

    override func setUp() {
        super.setUp()
        networkService = NetworkServiceMock()
        reviewsListService = ReviewsListServiceImpl(
            baseUrl: URL(string: "https://yandex.ru")!,
            networkService: networkService
        )
    }

    override func tearDown() {
        networkService = nil
        reviewsListService = nil
        super.tearDown()
    }

    func testSuccessGetReviewsList() {
        let reviews: [Review]? = [Review(idProduct: 111, idUser: 123, userName: "Иван", text: "Ноутбук"),
                                  Review(idProduct: 232, idUser: 123, userName: "Михаил", text: "Мышка")]

        networkService.result = reviews
        var resultListReviews: [Review]?
        reviewsListService.getReviewsList(idProduct: 1) { reviews in
            resultListReviews = reviews
        }
        XCTAssertNotNil(resultListReviews)
    }

    func testFailureGetReviewsList() {
        var resultListReviews: [Review]?
        reviewsListService.getReviewsList(idProduct: 1) { reviews in
            resultListReviews = reviews
        }
        XCTAssertNil(resultListReviews)
    }

}
