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
    }

    func testAddButton() {
        app.buttons["+"].tap()
    }

    func testSubtractButton() {
        app.buttons["-"].tap()
    }

    func testMultipliedButton() {
        app.buttons["x"].tap()
    }

    func testDivisionButton() {
        app.buttons["÷"].tap()
    }

    func testErrorForOperator() {
        app.buttons["1"].tap()
        app.buttons["-"].tap()
        app.buttons["+"].tap()
        app.alerts["Error"].buttons["OK"].tap()
    }

    func testResultButton() {
        app.buttons["1"].tap()
        app.buttons["+"].tap()
        app.buttons["3"].tap()
        app.buttons["x"].tap()
        app.buttons["2"].tap()
        app.buttons["="].tap()
    }

    func testAcButton() {
        app.buttons["1"].tap()
        app.buttons["+"].tap()
        app.buttons["3"].tap()
        app.buttons["⌫"].tap()
        app.buttons["⌫"].tap()
        app.buttons["⌫"].tap()
    }

    func testReset() {
        app.buttons["2"].tap()
        app.buttons["C"].tap()
    }
}
