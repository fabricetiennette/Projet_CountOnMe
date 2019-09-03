//
//  CountOnMeUITests.swift
//  CountOnMeUITests
//
//  Created by Fabrice Etiennette on 25/08/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest

class CountOnMeUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testNumPadButtons() {
        app.buttons["1"].tap()
        app.buttons["2"].tap()
        app.buttons["3"].tap()
        app.buttons["4"].tap()
        app.buttons["5"].tap()
        app.buttons["6"].tap()
        app.buttons["7"].tap()
        app.buttons["8"].tap()
        app.buttons["9"].tap()
        app.buttons["0"].tap()
        let exists = app.textViews["1234567890"].exists
        XCTAssertTrue(exists)
    }

    func testAddButton() {
        app.buttons["+"].tap()
        let exists = app.textViews[" +"].exists
        XCTAssertTrue(exists)

    }

    func testSubtractButton() {
        app.buttons["-"].tap()
        let exists = app.textViews[" -"].exists
        XCTAssertTrue(exists)
    }

    func testMultipliedButton() {
        app.buttons["x"].tap()
        let exists = app.textViews[" x"].exists
        XCTAssertTrue(exists)
    }

    func testDivisionButton() {
        app.buttons["÷"].tap()
        let exists = app.textViews[" ÷"].exists
        XCTAssertTrue(exists)
    }

    func testErrorForOperator() {
        app.buttons["1"].tap()
        app.buttons["-"].tap()
        app.buttons["+"].tap()
        let exists = app.alerts["Error"].exists
        XCTAssertTrue(exists)
    }

    func testResultButton() {
        app.buttons["1"].tap()
        app.buttons["+"].tap()
        app.buttons["3"].tap()
        app.buttons["x"].tap()
        app.buttons["2"].tap()
        app.buttons["="].tap()
        let exists = app.textViews["7"].exists
        XCTAssertTrue(exists)
    }

    func testBackSpaceButton() {
        app.buttons["1"].tap()
        app.buttons["+"].tap()
        app.buttons["3"].tap()
        app.buttons["⌫"].tap()
        app.buttons["⌫"].tap()
        let exists = app.textViews["1"].exists
        XCTAssertTrue(exists)
    }

    func testReset() {
        app.buttons["2"].tap()
        app.buttons["C"].tap()
        let exists = app.buttons["C"].exists
        XCTAssertFalse(exists)
    }

    func testAcButton() {
        app.buttons["1"].tap()
        app.buttons["⌫"].tap()
        let exists = app.buttons["AC"].exists
        XCTAssertTrue(exists)
    }

    func testDecimalAlert() {
        app.buttons["."].tap()
        let exists = app.alerts["Error"].exists
        XCTAssertTrue(exists)
    }

    func testExpressionIsCorreck() {
        app.buttons["1"].tap()
        app.buttons["+"].tap()
        app.buttons["="].tap()
        let exists = app.alerts["Error"].exists
        XCTAssertTrue(exists)
    }

    func testResultWithEmptyString() {
        app.buttons["="].tap()
        let exists = app.alerts["Error"].exists
        XCTAssertTrue(exists)
    }

    func testContinueWithResult() {
        app.buttons["1"].tap()
        app.buttons["+"].tap()
        app.buttons["3"].tap()
        app.buttons["x"].tap()
        app.buttons["2"].tap()
        app.buttons["="].tap()
        app.buttons["+"].tap()
        app.buttons["3"].tap()
        app.buttons["="].tap()
        let exists = app.textViews["10"].exists
        XCTAssertTrue(exists)
    }

    func testAddeDecimal() {
        app.buttons["1"].tap()
        app.buttons["."].tap()
        let exists = app.textViews["1."].exists
        XCTAssertTrue(exists)
    }
}
