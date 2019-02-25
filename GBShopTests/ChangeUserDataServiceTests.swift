//
//  ChangeUserDataServiceTests.swift
//  GBShopTests
//
//  Created by Olga Martyanova on 24/01/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import XCTest
@testable import GBShop

class ChangeUserDataServiceTests: XCTestCase {
    var networkService: NetworkServiceMock!
    var changeUserDataService: ChangeUserDataService!
    let user = User(id: 123,
                    login: nil,
                    name: nil,
                    lastname: nil,
                    username: "asdas",
                    password: "asdasd",
                    email: "somenew@somenew.ru",
                    gender: "m",
                    creditCard: "9872389-2424-234224-234",
                    bio: "This is good! I think I will switch to another language")

    override func setUp() {
        super.setUp()
        networkService = NetworkServiceMock()
        changeUserDataService = ChangeUserDataServiceImpl(
            baseUrl: URL(string: "https://yandex.ru")!,
            networkService: networkService
        )
    }

    override func tearDown() {
        networkService = nil
        changeUserDataService = nil
        super.tearDown()
    }

    func testSuccessChangeUserData() {
        networkService.result = ChangeUserDataResponse(result: 1)
        var resultTest: Int?
        changeUserDataService.changeUserData(userData: user) { result in
            resultTest = result
        }
        XCTAssertEqual(resultTest, 1)
    }

    func testFailureChangeUserData() {
        var resultTest: Int?
        changeUserDataService.changeUserData(userData: user) { result in
            resultTest = result
        }
        XCTAssertNotEqual(resultTest, 1)
    }
}
