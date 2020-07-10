//
//  API-DemoUITests.swift
//  API-DemoUITests
//
//  Created by Daniel Hilton on 25/06/2020.
//  Copyright © 2020 Daniel Hilton. All rights reserved.
//

import XCTest

class API_DemoUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false

    }

    override func tearDownWithError() throws {

    }


    func testDisplayCorrectSelectedUser() throws {
        let username = "Bret"
        let realName = "Leanne Graham"
        
        let app = XCUIApplication()
        app.activate()
        let userCell = app.tables.staticTexts[username]
        expectation(for: NSPredicate(format: "exists = 1"), evaluatedWith: userCell, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        userCell.tap()
        XCTAssertTrue(app.navigationBars[username].staticTexts[username].exists)
        XCTAssertTrue(app.staticTexts[realName].exists)
        
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
