//
//  AuthServiceTests.swift
//  GBShopTests
//
//  Created by Olga Martyanova on 24/01/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import XCTest
@testable import GBShop

class AuthServiceTests: XCTestCase {
    var networkService: NetworkServiceMock!
    var authService: AuthService!

    override func setUp() {
        super.setUp()
        networkService = NetworkServiceMock()

        authService = AuthServiceImpl(
            baseUrl: URL(string: "https://yandex.ru")!,
            networkService: networkService
        )
    }

    override func tearDown() {
        networkService = nil
        authService = nil
        super.tearDown()
    }

    func testSuccessAuth() {
        let user = User(id: 1,
                        login: "asd",
                        name: "asdas",
                        lastname: "asdasd",
                        username: nil,
                        password: nil,
                        email: nil,
                        gender: nil,
                        creditCard: nil,
                        bio: nil)

        networkService.result = LoginResponse(result: 1, user: user)

        var resultUser: User?
        authService.login(login: "asd", password: "asdas") { user in
            resultUser = user
        }
        XCTAssertNotNil(resultUser)
    }

    func testFailureAuth() {
        var resultUser: User?
        authService.login(login: "asd", password: "asdas") { user in
            resultUser = user
        }
        XCTAssertNil(resultUser)
    }
}
