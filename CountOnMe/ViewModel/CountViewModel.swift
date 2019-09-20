//
//  CountViewModel.swift
//  CountOnMe
//
//  Created by Fabrice Etiennette on 12/09/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import Foundation

struct CountViewModel {

    /// Instance of Calculate
    let calculate = Calculate()

    /// elementsRefactor split and map our value to return it in a string of array [""].
    func elementsRefactor(from text: String) -> [String] {
        return text.split(separator: " ").map { "\($0)" }
    }

    /// Get String from button title. Check if expression of elements is correct and return numberText. Set acButton title to "C".
    func displayNumbers(from title: String?, of elements: [String]) -> (String, String) {
        guard let numberText = title else { return ("", "") }

        if !calculate.expressionIsCorrect(elements: elements) {
            return (" \(numberText)", "C")
        }
        return ("\(numberText)", "C")
    }

    /// Check if a decimal point is already added. Check if expression of elements is correct return a decimal point.
    func displayDecimal(of elements: [String]) -> String {
        var decimal = ""
        if calculate.expressionIsCorrect(elements: elements) && !calculate.isDecimalAddedToLast(elements: elements) {
            decimal = "."
        }
        return decimal
    }

    /// Erase last elements for displayTextView.text. Set acButton title to "AC" when displayText is empty. trimmingCharacters is used remove a element containing whitespaces
    func eraseButtonTapped(displayText: String) -> (String, String) {
        var displayText = displayText
        if displayText.count > 0 {
            displayText.removeLast()
            displayText = displayText.trimmingCharacters(in: .whitespaces)
            if displayText.count == 0 {
                return (displayText, "AC")
            }
        }
        return (displayText, "C")
    }

    /// unitDisplay is use to add a operator for equation. Also prevent from having double unit. Check if expression of elements is correct and return unit.rawValue if not correct and alert appear on CountViewController. If user want to continue an equation with the present result it's possible.
    func unitDisplay(of elements: [String], unit: Calculate.Operator, displayView: String, resultView: String) -> (String, String, String) {
        var unitStr = ""
        var displayView = displayView
        var resultView = resultView
        if !calculate.expressionIsCorrect(elements: elements) {
            return (unitStr, displayView, resultView)
        } else if resultView != "0" {
            displayView = resultView
            resultView = "0"
            return (" \(unit.rawValue)", displayView, resultView)
        } else if displayView.count == 0 {
            displayView = "0"
            return (" \(unit.rawValue)", displayView, resultView)
        } else if calculate.expressionIsCorrect(elements: elements) {
            unitStr = " \(unit.rawValue)"
        }
        return (unitStr, displayView, resultView)
    }

    /// getResult check if expression of elements is correct and has enough element if not an alert appear on CountViewController else it return the result.
    func getResult(of elements: [String], resultText: String) -> String {
        var resultText = resultText
        guard calculate.expressionIsCorrect(elements: elements) else { return "0" }
        guard calculate.expressionHasEnoughElement(elements: elements) else { return "0" }
        if let result = calculate.calculate(elements: elements) {
            resultText = result
        }
        return resultText
    }

    /// Clear all calculation from user interface screen. set acButton title to "AC"
    func clearAll() -> (String, String, String) {
        return ("", "0", "AC")
    }
}
