//
//  RegisterServiceTests.swift
//  GBShopTests
//
//  Created by Olga Martyanova on 24/01/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import XCTest
@testable import GBShop

class RegisterServiceTests: XCTestCase {
    var networkService: NetworkServiceMock!
    var registerService: RegisterService!
    let user = User(id: 123,
                    login: nil,
                    name: nil,
                    lastname: nil,
                    username: "asdasdasd",
                    password: "asdasdas",
                    email: "some@some.ru",
                    gender: "m",
                    creditCard: "9872389-2424-234224-234",
                    bio: "This is good! I think I will switch to another language")

    override func setUp() {
        super.setUp()
        networkService = NetworkServiceMock()

        registerService = RegisterServiceImpl(
            baseUrl: URL(string: "https://yandex.ru")!,
            networkService: networkService
        )
    }

    override func tearDown() {
        networkService = nil
        registerService = nil
        super.tearDown()
    }

    func testSuccessRegister() {
        networkService.result = RegisterResponse(result: 1, userMessage: "Ok")
        var resultMessage: String?
        registerService.registerUser(userData: user) { message in
            resultMessage = message
        }
        XCTAssertNotNil(resultMessage)
    }

    func testFailureRegister() {
        var resultMessage: String?
        registerService.registerUser(userData: user) { message in
            resultMessage = message
        }
        XCTAssertNil(resultMessage)
    }
}
