//
//  OrderPaymentServiceTests.swift
//  GBShopTests
//
//  Created by Olga Martyanova on 04/02/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import XCTest
@testable import GBShop

class OrderPaymentServiceTests: XCTestCase {
    var networkService: NetworkServiceMock!
    var orderPaymentService: OrderPaymentService!

    override func setUp() {
        super.setUp()
        networkService = NetworkServiceMock()
        orderPaymentService = OrderPaymentServiceImpl(
            baseUrl: URL(string: "https://yandex.ru")!,
            networkService: networkService
        )
    }

    override func tearDown() {
        networkService = nil
        orderPaymentService = nil
        super.tearDown()
    }

    func testSuccessOrderPayment() {
        networkService.result = OrderPaymentResponse(result: 1, userMessage: "Ok")
        var resultMessage: String?
        orderPaymentService.orderPayment(idOrder: 123) { message in
            resultMessage = message
        }
        XCTAssertNotNil(resultMessage)
    }

    func testFailureOrderPayment() {
        var resultMessage: String?
        orderPaymentService.orderPayment(idOrder: 123) { message in
            resultMessage = message
        }
        XCTAssertNil(resultMessage)
    }
}
