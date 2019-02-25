//
//  DeleteProductServiceTests.swift
//  GBShopTests
//
//  Created by Olga Martyanova on 04/02/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import XCTest
@testable import GBShop

class DeleteProductServiceTests: XCTestCase {
    var networkService: NetworkServiceMock!
    var deleteProductService: DeleteProductService!

    override func setUp() {
        super.setUp()
        networkService = NetworkServiceMock()
        deleteProductService = DeleteProductServiceImpl(
            baseUrl: URL(string: "https://yandex.ru")!,
            networkService: networkService
        )
    }

    override func tearDown() {
        networkService = nil
        deleteProductService = nil
        super.tearDown()
    }

    func testSuccessDeleteProduct() {
        networkService.result = DeleteProductResponse(result: 1)
        var resultTest: Int?
        deleteProductService.deleteProduct(idProduct: 123) { result in
            resultTest = result
        }
        XCTAssertEqual(resultTest, 1)
    }

    func testFailureDeleteProduct() {
        var resultTest: Int?
        deleteProductService.deleteProduct(idProduct: 123) { result in
            resultTest = result
        }
        XCTAssertNotEqual(resultTest, 1)
    }

}
