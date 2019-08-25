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
        calculation.addNewNumber(numberText)
        displayOutput()
    }

    /// decimalButton is used to add decimal. Prevent also also double decimal.
    @IBAction func decimalButton(_ sender: UIButton) {
        if calculation.canAddDecimal {
            calculation.addDecimal()
            displayOutput()
        } else {
            alertPopUp(message: "Only one decimal point is accepted")
        }
    }

    // division button
    @IBAction func divisionButton(_ sender: UIButton) {
        unitDisplay(unit: "÷")
    }

    // multiplication button
    @IBAction func multiplicationButton(_ sender: UIButton) {
        unitDisplay(unit: "×")
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
        if !calculation.isExpressionCorrect {
            alertPopUp(message: "Uncomplete calculation")
        } else {
            let result = calculation.calculationLogic()
            resultOutput(result: result)
        }
        calculation.reset()
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
        if calculation.canAddOperator {
            calculation.operators.append(unit)
            calculation.elements.append("")
            displayOutput()
        } else {
            alertPopUp(message: "Only one operator is accepted")
        }
    }

    /// alertPopUp is use to creat alert for error or to warn for bad action
    func alertPopUp(message: String) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }

    /// displayOutput is use to display the value when user interact with the app
    func displayOutput() {
        var equationStr = ""
        for (index, itemChoose) in calculation.elements.enumerated() {
            if index > 0 {
                equationStr += calculation.operators[index]
            }
            equationStr += itemChoose
        }
        acButton.setTitle("C", for: .normal)
        displayTextView.text = equationStr
    }

    /// Clear all calculation from user interface screen
    func clearAll() {
        acButton.setTitle("AC", for: .normal)
        displayTextView.text = ""
        resultTextView.text = "0"
        calculation.reset()
    }

    /// resultOutput display the result of an equation
    func resultOutput(result: Double) {
        if result.isInfinite || result.isNaN {
            resultTextView.text = "Error"
        } else {
            resultTextView.text = "\(Double(result))"
        }
    }
}
