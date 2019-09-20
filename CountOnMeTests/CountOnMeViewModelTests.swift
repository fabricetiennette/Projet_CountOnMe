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
        var displayText = "123"
        var resultText = "12"
        let acButton = UIButton()
        acButton.titleLabel?.text = "C"
        let (clearText, backToZero, acButtonTitle) = countViewModel.clearAll()
        displayText = clearText
        resultText = backToZero
        acButton.setTitle(acButtonTitle, for: .normal)
        XCTAssertTrue(displayText == "")
        XCTAssertTrue(resultText == "0")
        XCTAssertTrue(acButton.title(for: .normal) == "AC")
    }

    func testBackSpaceKey() {
        let acButton = UIButton()
        acButton.titleLabel?.text = "C"
        var displayText = "1"
        let (text, title) = countViewModel.eraseButtonTapped(displayText: displayText)
        displayText = text
        acButton.setTitle(title, for: .normal)
        XCTAssertTrue(displayText == "")
        XCTAssertTrue(acButton.title(for: .normal) == "AC")
    }

    func testDisplayDecimal() {
        let elements = ["1"]
        let testAddingDecimal = countViewModel.displayDecimal(of: elements)
        XCTAssertEqual(testAddingDecimal, ".")
    }

    func testCannotAddDecimal() {
        let elements = ["1."]
        let testAddingDecimal = countViewModel.displayDecimal(of: elements)
        XCTAssertEqual(testAddingDecimal, "")
    }

    func testGetResult() {
        let elements = ["1", "+", "2"]
        var resultText = ""
        let result = countViewModel.getResult(of: elements, resultText: resultText)
        resultText = result
        XCTAssertEqual(resultText, "3")
    }

    func testGetResultHasEnoughElements() {
        let elements = ["1"]
        var resultText = ""
        let result = countViewModel.getResult(of: elements, resultText: resultText)
        resultText = result
        XCTAssertEqual(resultText, "0")
    }

    func testGetResultExpressionIsCorrect() {
        let elements = ["1", "+"]
        var resultText = ""
        let result = countViewModel.getResult(of: elements, resultText: resultText)
        resultText = result
        XCTAssertEqual(resultText, "0")
    }

    func testUnitDisplay() {
        let elements = ["1"]
        let unit = Calculate.Operator.add
        var displayView = "1"
        var resultView = "0"
        let (add, text, resultViewText) = countViewModel.unitDisplay(of: elements, unit: unit, displayView: displayView, resultView: resultView)
        displayView = text
        resultView = resultViewText
        displayView.append(add)
        XCTAssertTrue(displayView == "1 +")
        XCTAssertTrue(resultView == "0")
    }

    func testUnitDisplayContinueWithResult() {
        let elements = ["1", "+", "3"]
        let unit = Calculate.Operator.multiply
        var displayView = "1 + 3"
        var resultView = "4"
        let (multiply, text, resultViewText) = countViewModel.unitDisplay(of: elements, unit: unit, displayView: displayView, resultView: resultView)
        displayView = text
        resultView = resultViewText
        displayView.append(multiply)
        XCTAssertTrue(displayView == "4 x")
        XCTAssertTrue(resultView == "0")
    }

    func testUnitDisplayWhenAddingASecondOperator() {
        let elements = ["1", "+"]
        let unit = Calculate.Operator.divide
        var displayView = "1 +"
        var resultView = "0"
        let (divide, text, resultViewText) = countViewModel.unitDisplay(of: elements, unit: unit, displayView: displayView, resultView: resultView)
        displayView = text
        resultView = resultViewText
        displayView.append(divide)
        XCTAssertTrue(displayView == "1 +")
        XCTAssertTrue(resultView == "0")
    }

    func testDisplayNumber() {
        let numpadButton = UIButton()
        numpadButton.setTitle("2", for: .normal)
        let elements = [String]()
        let acButton = UIButton()
        acButton.titleLabel?.text = "AC"
        var displayText = ""
        let (numberText, acButtonTitle) = countViewModel.displayNumbers(from: numpadButton.title(for: .normal), of: elements)
        displayText.append(numberText)
        acButton.setTitle(acButtonTitle, for: .normal)
        XCTAssertTrue(displayText == "2")
        XCTAssertTrue(acButton.title(for: .normal) == "C")
    }

    func testDisplayNumberWhenLastElementIsAUnit() {
        let numpadButton = UIButton()
        numpadButton.setTitle("4", for: .normal)
        let elements = ["1", "+"]
        let acButton = UIButton()
        acButton.titleLabel?.text = "C"
        let (numberText, acButtonTitle) = countViewModel.displayNumbers(from: numpadButton.title(for: .normal), of: elements)
        acButton.setTitle(acButtonTitle, for: .normal)
        XCTAssertEqual(numberText, " 4")
        XCTAssertTrue(acButton.title(for: .normal) == "C")
    }

    func testDisplayNumberDefaultValue() {
        let numpadButton = UIButton()
        let elements = ["1", "+"]
        let acButton = UIButton()
        acButton.titleLabel?.text = "C"
        let (numberText, acButtonTitle) = countViewModel.displayNumbers(from: numpadButton.title(for: .normal), of: elements)
        XCTAssertEqual(numberText, "")
        XCTAssertEqual(acButtonTitle, "")
    }
}
