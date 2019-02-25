//
//  ExitServiceTests.swift
//  GBShopTests
//
//  Created by Olga Martyanova on 24/01/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import XCTest
@testable import GBShop

class ExitServiceTests: XCTestCase {
    var networkService: NetworkServiceMock!
    var exitService: ExitService!

    override func setUp() {
        super.setUp()

        networkService = NetworkServiceMock()

        exitService = ExitServiceImpl(
            baseUrl: URL(string: "https://yandex.ru")!,
            networkService: networkService
        )
    }

    override func tearDown() {
        networkService = nil
        exitService = nil
        super.tearDown()
    }

    func testSuccessExit() {
        networkService.result = LogoutResponse(result: 1)

        var resultTest: Int?
        exitService.logout(id: 123) { result in
            resultTest = result
        }
        XCTAssertEqual(resultTest, 1)
    }

    func testFailureExit() {
        var resultTest: Int?
        exitService.logout(id: 123) { result in
            resultTest = result
        }
        XCTAssertNotEqual(resultTest, 1)
    }
}
