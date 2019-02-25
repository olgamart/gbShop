//
//  GBShopUITests.swift
//  GBShopUITests
//
//  Created by Olga Martyanova on 21/02/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import XCTest

class GBShopUITests: XCTestCase {

   let app = XCUIApplication()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        setupSnapshot(app)
        app.launch()
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
       
        snapshot("LoginScreen")
        
        app.otherElements.containing(.staticText, identifier: "Логин").children(matching: .secureTextField).element.tap()
        app.buttons["Вход"].tap()
        app.alerts["Ошибка"].buttons["OK"].tap()
        
        snapshot("LoginScreen")
    }

}
