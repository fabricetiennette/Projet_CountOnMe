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

    func makeElements(from text: String) -> [String] {
        return text.split(separator: " ").map { "\($0)" }
    }

    func displayNumbers(from button: UIButton, elements: [String], acButton: UIButton) -> String {
        guard let numberText = button.title(for: .normal) else { return "" }

        if !calculate.expressionIsCorrect(elements: elements) {
            return " \(numberText)"
        }
        acButton.setTitle("C", for: .normal)
        return "\(numberText)"
    }

    func displayDecimal(on countViewController: UIViewController, elements: [String]) -> String {
        var decimal = ""
        if calculate.isDecimalAddedToLast(elements: elements) {
            alertPopUp(on: countViewController, message: "An decimal point has already been added")
        } else if calculate.expressionIsCorrect(elements: elements) {
            decimal = "."
        }
        return decimal
    }

    func eraseLast(displayText: inout String, acButton: UIButton) {
        if displayText.count > 0 {
            displayText.removeLast()
            // Helps me remove a element containing whitespaces
            displayText = displayText.trimmingCharacters(in: .whitespaces)
            if displayText.count == 0 {
                acButton.setTitle("AC", for: .normal)
            }
        }
    }

    func getResult(on countViewController: UIViewController, elements: [String], resultText: inout String) {
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

    /// alertPopUp is use to create alert for error or to warn for bad action
    func alertPopUp(on countViewController: UIViewController, message: String) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        countViewController.present(alertVC, animated: true, completion: nil)
    }

    /// unitDisplay is use to add a operator for equation. Also prevent from having double unit.
    func unitDisplay(on countViewController: UIViewController, elements: [String], unit: Calculate.Operator, displayView: inout String, resultView: inout String) -> String {
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

    /// Clear all calculation from user interface screen
    func clearAll(acButton: UIButton, disPlayText: inout String, resultText: inout String) {
        acButton.setTitle("AC", for: .normal)
        disPlayText = ""
        resultText = "0"
    }
}
