//
//  AddProductServiceTests.swift
//  GBShopTests
//
//  Created by Olga Martyanova on 04/02/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import XCTest
@testable import GBShop

class AddProductServiceTests: XCTestCase {
    var networkService: NetworkServiceMock!
    var addProductService: AddProductService!

    override func setUp() {
        super.setUp()
        networkService = NetworkServiceMock()
        addProductService = AddProductServiceImpl(
            baseUrl: URL(string: "https://yandex.ru")!,
            networkService: networkService
        )
    }

    override func tearDown() {
        networkService = nil
        addProductService = nil
        super.tearDown()
    }

    func testSuccessAddProduct() {
        networkService.result = AddProductResponse(result: 1, userMessage: "Ok")
        var resultMessage: String?
        addProductService.addProduct(idProduct: 123, quantity: 1) { message in
            resultMessage = message
        }
        XCTAssertNotNil(resultMessage)
    }

    func testFailureAddProduct() {
        var resultMessage: String?
        addProductService.addProduct(idProduct: 123, quantity: 1) { message in
            resultMessage = message
        }
        XCTAssertNil(resultMessage)
    }
}
