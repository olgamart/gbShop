//
//  NetworkServiceFactoryTests.swift
//  GBShopTests
//
//  Created by Olga Martyanova on 25/01/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import XCTest
@testable import GBShop

class NetworkServiceFactoryTests: XCTestCase {
    var networkServiceFactory: NetworkServiceFactory!
    var networkService: NetworkServiceMock!

    override func setUp() {
        super.setUp()
        networkService = NetworkServiceMock()
        networkServiceFactory = NetworkServiceFactory.shared
    }

    override func tearDown() {
        networkService = nil
        super.tearDown()
    }

    func testSuccessAuthService() {
        var authServiceTest: AuthService

        authServiceTest = networkServiceFactory.makeAuthService()
        XCTAssertTrue(object_getClass(authServiceTest) ==  AuthServiceImpl.self)
    }

    func testFailureAuthService() {
        var authServiceTest: AuthService

        authServiceTest = networkServiceFactory.makeAuthService()
        XCTAssertFalse(object_getClass(authServiceTest) !=  AuthServiceImpl.self)
    }

    func testSuccessExitService() {
        var exitServiceTest: ExitService

        exitServiceTest = networkServiceFactory.makeExitService()
        XCTAssertTrue(object_getClass(exitServiceTest) ==  ExitServiceImpl.self)
    }

    func testFailureExitService() {
        var exitServiceTest: ExitService

        exitServiceTest = networkServiceFactory.makeExitService()
        XCTAssertFalse(object_getClass(exitServiceTest) !=  ExitServiceImpl.self)
    }

    func testSuccessRegisterService() {

        var registerServiceTest: RegisterService

        registerServiceTest = networkServiceFactory.makeRegisterService()
        XCTAssertTrue(object_getClass(registerServiceTest) ==  RegisterServiceImpl.self)
    }

    func testFailureRegisterService() {
        var registerServiceTest: RegisterService

        registerServiceTest = networkServiceFactory.makeRegisterService()
        XCTAssertFalse(object_getClass(registerServiceTest) !=  RegisterServiceImpl.self)
    }

    func testSuccessChangeUserDataService() {
        var changeUserDataServiceTest: ChangeUserDataService

        changeUserDataServiceTest = networkServiceFactory.makeChangeUserDataService()
        XCTAssertTrue(object_getClass(changeUserDataServiceTest) ==  ChangeUserDataServiceImpl.self)
    }

    func testFailureChangeUserDataService() {
        var changeUserDataServiceTest: ChangeUserDataService

        changeUserDataServiceTest = networkServiceFactory.makeChangeUserDataService()
        XCTAssertFalse(object_getClass(changeUserDataServiceTest) !=  ChangeUserDataServiceImpl.self)
    }

    func testSuccessProductService() {
        var productServiceTest: ProductService

        productServiceTest = networkServiceFactory.makeProductService()
        XCTAssertTrue(object_getClass(productServiceTest) ==  ProductServiceImpl.self)
    }

    func testFailureProductService() {
        var productServiceTest: ProductService

        productServiceTest = networkServiceFactory.makeProductService()
        XCTAssertFalse(object_getClass(productServiceTest) !=  ProductServiceImpl.self)
    }

    func testSuccessProductsListService() {

        var productsListServiceTest: ProductsListService

        productsListServiceTest = networkServiceFactory.makeProductsListService()
        XCTAssertTrue(object_getClass(productsListServiceTest) ==  ProductsListServiceImpl.self)
    }

    func testFailureProductsListService() {
        var productsListServiceTest: ProductsListService

        productsListServiceTest = networkServiceFactory.makeProductsListService()
        XCTAssertFalse(object_getClass(productsListServiceTest) !=  ProductsListServiceImpl.self)
    }

}
