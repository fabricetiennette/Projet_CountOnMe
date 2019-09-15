//
//  CountOnMeViewModelTests.swift
//  CountOnMeTests
//
//  Created by Fabrice Etiennette on 12/09/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CountOnMeViewModelTests: XCTestCase {

    var countViewModel: CountViewModel!

    override func setUp() {
        countViewModel = CountViewModel()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        countViewModel = nil
        super.tearDown()
    }

    func testElementsRefactor() {
        let text = "123"
        let elements = countViewModel.elementsRefactor(from: text)
        XCTAssertEqual(elements, ["123"])
    }

    func testClearAll() {
        let acButton = UIButton()
        acButton.titleLabel?.text = "C"
        var displayText = "123"
        var resultText = "12"
        countViewModel.clearAll(set: acButton, disPlayText: &displayText, resultText: &resultText)
        XCTAssertTrue(displayText == "")
        XCTAssertTrue(resultText == "0")
        XCTAssertTrue(acButton.title(for: .normal) == "AC")
    }

    func testBackSpaceKey() {
        let acButton = UIButton()
        acButton.titleLabel?.text = "C"
        var displayText = "1"
        countViewModel.backSpaceKey(displayText: &displayText, set: acButton)
        XCTAssertTrue(displayText == "")
        XCTAssertTrue(acButton.title(for: .normal) == "AC")
    }

    func testDisplayDecimal() {
        let elements = ["1"]
        let countViewController = UIViewController()
        let testAddingDecimal = countViewModel.displayDecimal(on: countViewController, of: elements)
        XCTAssertEqual(testAddingDecimal, ".")
    }

    func testCannotAddDecimal() {
        let elements = ["1."]
        let countViewController = UIViewController()
        let testAddingDecimal = countViewModel.displayDecimal(on: countViewController, of: elements)
        XCTAssertEqual(testAddingDecimal, "")
    }

    func testGetResult() {
        let countViewController = UIViewController()
        let elements = ["1", "+", "2"]
        var resultText = ""
        countViewModel.getResult(on: countViewController, of: elements, resultText: &resultText)
        XCTAssertTrue(resultText == "3")
    }

    func testGetResultHasEnoughElements() {
        let countViewController = UIViewController()
        let elements = ["1"]
        var resultText = ""
        countViewModel.getResult(on: countViewController, of: elements, resultText: &resultText)
        XCTAssertTrue(resultText == "")
    }

    func testGetResultExpressionIsCorrect() {
        let countViewController = UIViewController()
        let elements = ["1", "+"]
        var resultText = ""
        countViewModel.getResult(on: countViewController, of: elements, resultText: &resultText)
        XCTAssertTrue(resultText == "")
    }

    func testUnitDisplay() {
        let countViewController = UIViewController()
        let elements = ["1"]
        let unit = Calculate.Operator.add
        var displayView = "1"
        var resultView = "0"
        let unitToDisplay = countViewModel.unitDisplay(on: countViewController, of: elements, unit: unit, displayView: &displayView, resultView: &resultView)
        XCTAssertEqual(unitToDisplay, " +")
    }

    func testUnitDisplayContinueWithResult() {
        let countViewController = UIViewController()
        let elements = ["1", "+", "3"]
        let unit = Calculate.Operator.multiply
        var displayView = "1 + 3"
        var resultView = "4"
        let unitToDisplay = countViewModel.unitDisplay(on: countViewController, of: elements, unit: unit, displayView: &displayView, resultView: &resultView)
        XCTAssertEqual(unitToDisplay, " x")
    }

    func testUnitDisplayAlertPopUp() {
        let countViewController = UIViewController()
        let elements = ["1", "+"]
        let unit = Calculate.Operator.divide
        var displayView = "1 +"
        var resultView = "0"
        let unitToDisplay = countViewModel.unitDisplay(on: countViewController, of: elements, unit: unit, displayView: &displayView, resultView: &resultView)
        XCTAssertEqual(unitToDisplay, "")
    }

    func testDisplayNumber() {
        let numpadButton = UIButton()
        numpadButton.setTitle("2", for: .normal)
        let elements = [String]()
        let acButton = UIButton()
        acButton.titleLabel?.text = "AC"
        let numberText = countViewModel.displayNumbers(from: numpadButton, of: elements, set: acButton)
        XCTAssertEqual(numberText, "2")
        XCTAssertTrue(acButton.title(for: .normal) == "C")
    }

    func testDisplayNumberWhenLastElementIsAUnit() {
        let numpadButton = UIButton()
        numpadButton.setTitle("4", for: .normal)
        let elements = ["1", "+"]
        let acButton = UIButton()
        acButton.titleLabel?.text = "C"
        let numberText = countViewModel.displayNumbers(from: numpadButton, of: elements, set: acButton)
        XCTAssertEqual(numberText, " 4")
    }

    func testDisplayNumberDefaultValue() {
        let numpadButton = UIButton()
        let elements = ["1", "+"]
        let acButton = UIButton()
        acButton.titleLabel?.text = "C"
        let numberText = countViewModel.displayNumbers(from: numpadButton, of: elements, set: acButton)
        XCTAssertEqual(numberText, "")
    }
}
