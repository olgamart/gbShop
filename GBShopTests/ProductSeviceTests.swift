//
//  ProductSeviceTests.swift
//  GBShopTests
//
//  Created by Olga Martyanova on 24/01/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import XCTest
@testable import GBShop

class ProductSeviceTests: XCTestCase {
    var networkService: NetworkServiceMock!
    var productSevice: ProductService!

    override func setUp() {
        super.setUp()
        networkService = NetworkServiceMock()
        productSevice = ProductServiceImpl(
            baseUrl: URL(string: "https://yandex.ru")!,
            networkService: networkService
        )
    }

    override func tearDown() {
        networkService = nil
        productSevice = nil
        super.tearDown()
    }

    func testSuccessGetProduct() {
        networkService.result = ProductResponse(result: 1,
                                                productName: "Ноутбук",
                                                productPrice: 45600,
                                                productDescription: "Мощный игровой ноутбук")
        var resultProduct: ProductResponse?
        productSevice.getProduct(idProduct: 123) { product in
            resultProduct = product
        }
        XCTAssertNotNil(resultProduct)
    }

    func testFailureGetProduct() {
        var resultProduct: ProductResponse?
        productSevice.getProduct(idProduct: 123) { product in
            resultProduct = product
        }
        XCTAssertNil(resultProduct)
    }
}
