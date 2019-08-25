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

    var testCalculation: Calculate!

    // Reset before each test method in a test case is called.
    override func setUp() {
        testCalculation = Calculate()
    }

    // Test if expression is correct
    func testForIsExpressionCorrect() {
        testCalculation.addNewNumber("9")
        XCTAssertTrue(testCalculation.isExpressionCorrect)
    }

    // Test if espression is not correct
    func testForIsExpressionNotCorrect() {
        testCalculation.addNewNumber("")
        testCalculation.operators[0] = "+"
        testCalculation.elements[0] = ""
        XCTAssertFalse(testCalculation.isExpressionCorrect)
    }

    // Test if can add an operator
    func testIfCanAddOperator() {
        testCalculation.elements[0] = "4"
        testCalculation.elements[0] = "0.0"
        XCTAssertTrue(testCalculation.canAddOperator)
    }

    // Test if cannot add any operator
    func testIfCanNotAddOperator() {
        testCalculation.elements[0] = ""
        testCalculation.operators[0] = "+"
        XCTAssertFalse(testCalculation.canAddOperator)
    }

    // Test if can add a decimal point
    func testIfCanAddDecimal() {
        testCalculation.elements[0] = "1"
        XCTAssertTrue(testCalculation.canAddDecimal)
    }

    // Test if cannot add a decimal
    func testIfCanNotAddDecimal() {
        testCalculation.elements[0] = ""
        testCalculation.addDecimal()
        XCTAssertFalse(testCalculation.canAddDecimal)
    }

    // Test if can reset calculate properties
    func testIfCanResetCaculateProperties() {
        testCalculation.reset()
        XCTAssertTrue(testCalculation.operators == ["+"])
        XCTAssertTrue(testCalculation.elements == [""])
    }

    // Test if cannot reset calculate propeties
    func testIfCanNotResetCaculateMemory() {
        testCalculation.reset()
        XCTAssertFalse(testCalculation.operators == ["+", "-"])
        XCTAssertFalse(testCalculation.elements == ["1", "4", "8"])
    }
}
