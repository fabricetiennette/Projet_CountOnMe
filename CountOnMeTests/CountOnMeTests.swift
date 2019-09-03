//
//  CountOnMeTests.swift
//  CountOnMeTests
//
//  Created by Fabrice Etiennette on 20/08/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CountOnMeTests: XCTestCase {

    var calculate: Calculate!

    // Reset before each test method in a test case is called.
    override func setUp() {
        calculate = Calculate()
    }

    override func tearDown() {
        calculate = nil
        super.tearDown()
    }

    // Test if expression is correct
    func testForIsExpressionCorrect_when1Plus2MultipliedBy3_thenResultShouldReturnTrue() {
        let elements = ["1", "+", "2", "x", "3"]
        XCTAssertTrue(calculate.expressionIsCorrect(elements: elements))
        }

    func testForIsExpressionCorrect_when2PlusSubstract_thenResultShouldReturnFalse() {
        let elements = ["2", "+", "-"]
        XCTAssertFalse(calculate.expressionIsCorrect(elements: elements))
    }

    // Test if espression is not correct
    func testForExpressionHasEnoughElment_when1Plus3_thenResultShouldReturnTrue() {
        let elements = ["1", "+", "3"]
        XCTAssertTrue(calculate.expressionHasEnoughElement(elements: elements))
    }

    // Test if can append a decimal. True return an Error message to the user
    func testIfDecimalIsAdded_whenLastElementHasDecimal_thenResultShouldReturnTrue() {
        let elements = ["1."]
        XCTAssertTrue(calculate.isDecimalAddedToLast(elements: elements))
    }

    // Test if can append a decimal. True return an Error message to the user
    func testIfDecimalIsAdded_whenLastElementIsEmpty_thenResultShouldReturnTrue() {
        let elements = [""]
        XCTAssertTrue(calculate.isDecimalAddedToLast(elements: elements))
    }

    // Test if can append a decimal. False let the user add a decimal point
    func testIfDecimalIsAdded_whenLastElementNotDecimalAvailable_thenResultShouldReturnFalse() {
        let elements = ["1"]
        XCTAssertFalse(calculate.isDecimalAddedToLast(elements: elements))
    }

    // Test if can append a decimal. True return an Error message to the user
    func testIfDecimalIsAdded_whenElementArrayIsEmpty_thenResultShouldReturnFalse() {
        let elements = [String]()
        XCTAssertTrue(calculate.isDecimalAddedToLast(elements: elements))
    }

    func testOfCalculation_when2MultipliedBy3_thenResultShouldBe6() {
        let elements = ["2", "+", "3"]
        XCTAssertEqual(calculate.calculate(elements: elements), "5")
    }

    func testOfCalculation_when3MultipliedBy2Dividedby4_thenResultShouldbe1Decimal5() {
        let elements = ["3", "x", "2", "÷", "4"]
        XCTAssertEqual(calculate.calculate(elements: elements), "1.5")
    }

    func testOfCalculation_when6MultipliedBy10MinusBy4DividedBy2_thenResultShouldBe58() {
        let elements = ["6", "x", "10", "-", "4", "÷", "2"]
        XCTAssertEqual(calculate.calculate(elements: elements), "58")
    }

    func testOfCalculation_when3Multiplied3Minus2DividedBy3_ThenResultIs8() {
        let elements = ["3", "+", "3", "x", "2", "-", "3", "÷", "3"]
        XCTAssertEqual(calculate.calculate(elements: elements), "8")
    }

    func testDivisionBy0_when3DividedBy0_thenResultShouldBeInfinity() {
        let elements = ["3", "÷", "0"]
        XCTAssertEqual(calculate.calculate(elements: elements), "Error")
    }
}
