//
//  CountController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class CountViewController: UIViewController {

    /// Instance of Calculate
    private var calculation = Calculate()

    private var elements: [String] {
        return displayTextView.text.split(separator: " ").map { "\($0)" }
    }

    // MARK: - Outlets
    @IBOutlet weak private var displayTextView: UITextView!
    @IBOutlet weak private var resultTextView: UITextView!
    @IBOutlet private var numberButtons: [UIButton]!
    @IBOutlet weak private var acButton: UIButton!
}

// MARK: - IBAction
private extension CountViewController {

    /// numPadButton is used to add numbers for equations
    @IBAction func numPadButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else { return }

        if !calculation.expressionIsCorrect(elements: elements) {
            displayTextView.text.append(" \(numberText)")
        } else {
            displayTextView.text.append("\(numberText)")
        }
        acButton.setTitle("C", for: .normal)
    }

    /// decimalButton is used to add decimal. Prevent also also double decimal.
    @IBAction func decimalButton(_ sender: UIButton) {
        if calculation.isDecimalAddedToLast(elements: elements) {
            alertPopUp(message: "An Operator was already added")
        } else if calculation.expressionIsCorrect(elements: elements) {
            displayTextView.text.append(".")
        }
    }

    // This method is used to erased the last element
    @IBAction func backSpace() {
        if displayTextView.text.count > 0 {
            displayTextView.text.removeLast()
            // Helps me remove a element containing whitespaces
            displayTextView.text = displayTextView.text.trimmingCharacters(in: .whitespaces)
            if displayTextView.text.count == 0 {
                acButton.setTitle("AC", for: .normal)
            }
        }
    }

    // division button
    @IBAction func divisionButton(_ sender: UIButton) {
        unitDisplay(unit: "÷")
    }

    // multiplication button
    @IBAction func multiplicationButton(_ sender: UIButton) {
        unitDisplay(unit: "x")
    }

    // addition button
    @IBAction func additionButton() {
        unitDisplay(unit: "+")
    }

    // substraction button
    @IBAction func substractionButton() {
        unitDisplay(unit: "-")
    }

    /// result button. It check if there is a correct equation for calculate and also prevent from having NaN and inf.
    @IBAction func resultButton() {
        guard calculation.expressionIsCorrect(elements: elements) else {
            alertPopUp(message: "Uncorrect expression")
            return
        }

        guard calculation.expressionHasEnoughElement(elements: elements) else {
            alertPopUp(message: "Cannot get any result")
            return
        }
        if let result = calculation.calculTotal(elements: elements) {
            resultTextView.text = result
        }
    }

    /// AC button reset all text view
    @IBAction func resetDisplay(_ sender: UIButton) {
        clearAll()
    }
}

// MARK: - Methods

private extension CountViewController {

    /// unitDisplay is use to add a operator for equation. Also prevent from having double unit.
    func unitDisplay(unit: String) {
        if !calculation.expressionIsCorrect(elements: elements) {
            alertPopUp(message: "An Operator was already added")
        } else if resultTextView.text != "0" {
            displayTextView.text = resultTextView.text
            resultTextView.text = "0"
            displayTextView.text.append(" \(unit)")
        } else if calculation.expressionIsCorrect(elements: elements) {
            displayTextView.text.append(" \(unit)")
        }
    }

    /// alertPopUp is use to creat alert for error or to warn for bad action
    func alertPopUp(message: String) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }

    /// Clear all calculation from user interface screen
    func clearAll() {
        acButton.setTitle("AC", for: .normal)
        displayTextView.text = ""
        resultTextView.text = "0"
    }
}
