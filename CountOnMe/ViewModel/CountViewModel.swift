//
//  CountViewModel.swift
//  CountOnMe
//
//  Created by Fabrice Etiennette on 12/09/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import Foundation
import UIKit

struct CountViewModel {

    /// Instance of Calculate
    let calculate = Calculate()

    /// elementsRefactor split and map our value to return it in a string of array [""].
    func elementsRefactor(from text: String) -> [String] {
        return text.split(separator: " ").map { "\($0)" }
    }

    /// Get String from button title. Check if expression of elements is correct and return numberText. Set acButton title to "C".
    func displayNumbers(from button: UIButton, of elements: [String], set acButton: UIButton) -> String {
        guard let numberText = button.title(for: .normal) else { return "" }

        if !calculate.expressionIsCorrect(elements: elements) {
            return " \(numberText)"
        }
        acButton.setTitle("C", for: .normal)
        return "\(numberText)"
    }

    /// Check if a decimal point is already added. Check if expression of elements is correct return a decimal point.
    func displayDecimal(on countViewController: UIViewController, of elements: [String]) -> String {
        var decimal = ""
        if calculate.isDecimalAddedToLast(elements: elements) {
            alertPopUp(on: countViewController, message: "An decimal point has already been added")
        } else if calculate.expressionIsCorrect(elements: elements) {
            decimal = "."
        }
        return decimal
    }

    /// Erase last elements for displayTextView.text. Set acButton title to "AC" when displayText is empty. trimmingCharacters is used remove a element containing whitespaces
    func backSpaceKey(displayText: inout String, set acButton: UIButton) {
        if displayText.count > 0 {
            displayText.removeLast()
            displayText = displayText.trimmingCharacters(in: .whitespaces)
            if displayText.count == 0 {
                acButton.setTitle("AC", for: .normal)
            }
        }
    }

    /// unitDisplay is use to add a operator for equation. Also prevent from having double unit. Check if expression of elements is correct and return unit.rawValue if not correct and alert appear on CountViewController. If user want to continue an equation with the present result it's possible.
    func unitDisplay(on countViewController: UIViewController, of elements: [String], unit: Calculate.Operator, displayView: inout String, resultView: inout String) -> String {
        var unitStr = ""
        if !calculate.expressionIsCorrect(elements: elements) {
            alertPopUp(on: countViewController, message: "An Operator was already added")
        } else if resultView != "0" {
            displayView = resultView
            resultView = "0"
            return " \(unit.rawValue)"
        } else if calculate.expressionIsCorrect(elements: elements) {
            unitStr = " \(unit.rawValue)"
        }
        return unitStr
    }

    /// getResult check if expression of elements is correct and has enough element if not an alert appear on CountViewController else it return the result.
    func getResult(on countViewController: UIViewController, of elements: [String], resultText: inout String) {
        guard calculate.expressionIsCorrect(elements: elements) else {
            alertPopUp(on: countViewController, message: "Uncorrect expression")
            return
        }
        guard calculate.expressionHasEnoughElement(elements: elements) else {
            alertPopUp(on: countViewController, message: "Cannot get any result")
            return
        }
        if let result = calculate.calculate(elements: elements) {
            resultText = result
        }
    }

    /// Clear all calculation from user interface screen. set acButton title to "AC"
    func clearAll(set acButton: UIButton, disPlayText: inout String, resultText: inout String) {
        acButton.setTitle("AC", for: .normal)
        disPlayText = ""
        resultText = "0"
    }

    /// alertPopUp is use to create alert for error or to warn for bad action
    func alertPopUp(on countViewController: UIViewController, message: String) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        countViewController.present(alertVC, animated: true, completion: nil)
    }
}
