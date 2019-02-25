//
//  ErrorParserTests.swift
//  GBShopTests
//
//  Created by Olga Martyanova on 24/01/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import XCTest
@testable import GBShop

class ErrorParserTests: XCTestCase {
    var errorParser: ErrorParser!

    override func setUp() {
        super.setUp()
        errorParser = ErrorParserImpl()
    }

    override func tearDown() {
        errorParser = nil
        super.tearDown()
    }

    func testSuccessParse() {
        let context = DecodingError.Context.init(codingPath: [], debugDescription: "sadasd")
        let codableError = DecodingError.dataCorrupted(context)

        let error = NSError(domain: "asdas", code: 12, userInfo: nil)

        let appError = errorParser.parse(codableError)
        let someError = errorParser.parse(error)

        XCTAssertEqual(appError, AppError.serverError)
        XCTAssertEqual(someError, AppError.undefened)
    }

    func testFailParse() {
        let error = NSError(domain: "asdas", code: 12, userInfo: nil)
        let appError = errorParser.parse(error)
        XCTAssertNotEqual(appError, AppError.serverError)
    }

}
