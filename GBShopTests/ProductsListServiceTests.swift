//
//  ProductsListServiceTests.swift
//  GBShopTests
//
//  Created by Olga Martyanova on 24/01/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import XCTest
@testable import GBShop

class ProductsListServiceTests: XCTestCase {
    var networkService: NetworkServiceMock!
    var productsListService: ProductsListService!

    override func setUp() {
        super.setUp()
        networkService = NetworkServiceMock()
        productsListService = ProductsListServiceImpl(
            baseUrl: URL(string: "https://yandex.ru")!,
            networkService: networkService
        )
    }

    override func tearDown() {
        networkService = nil
        productsListService = nil
        super.tearDown()
    }

    func testSuccessGetProductsList() {
        let products: [Product]? = [Product(idProduct: 123, productName: "Ноутбук", price: 45600),
                                    Product(idProduct: 456, productName: "Мышка", price: 1000)]

        networkService.result = products
        var resultListProducts: [Product]?
        productsListService.getProductsList(pageNumber: 1, idCategory: 1) { products in
            resultListProducts = products
        }
        XCTAssertNotNil(resultListProducts)
    }

    func testFailureGetProductsList() {
        var resultListProducts: [Product]?
        productsListService.getProductsList(pageNumber: 1, idCategory: 1) { products in
            resultListProducts = products
        }
        XCTAssertNil(resultListProducts)
    }
}
