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

    var calculation: Calculate!

    override func setUp() {
        calculation = Calculate()
    }

    func testIsExpressionCorrect() {
        calculation.addNewNumber("9")
        XCTAssertTrue(calculation.isExpressionCorrect)
    }

    func testIsExpressionNotCorrect() {
        calculation.addNewNumber("")
        calculation.operators[0] = "+"
        calculation.elements[0] = ""
        XCTAssertFalse(calculation.isExpressionCorrect)
    }

    func testIfCanAddOperator() {
        calculation.elements[0] = "4"
        calculation.elements[0] = "0.0"
        XCTAssertTrue(calculation.canAddOperator)
    }

    func testIfCanNotAddOperator() {
        calculation.elements[0] = ""
        calculation.operators[0] = "+"
        XCTAssertFalse(calculation.canAddOperator)
    }

}
