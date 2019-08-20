//
//  CountController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class CountViewController: UIViewController {
    @IBOutlet private weak var resultTextView: UITextView!
    @IBOutlet private weak var displayCalculation: UITextView!
    @IBOutlet private var numberButtons: [UIButton]!
    @IBOutlet private var equationButtons: [UIButton]!
    @IBOutlet private weak var  refeshButton: UIButton!
    @IBOutlet private weak var equalButton: UIButton!

    var elements: [String] {
        return displayCalculation.text.split(separator: " ").map { "\($0)" }
    }

    // Error check computed variables
    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/" && elements.last != "%"
    }

    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }

    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/" && elements.last != "%"
    }

    var expressionHaveResult: Bool {
        return resultTextView.text.firstIndex(of: "=") != nil
    }
}

private extension CountViewController {
    @IBAction func refresh() {
        equationButtons.forEach {$0.layer.opacity = 1}
        resultTextView.text = ""
        displayCalculation.text = ""
        refeshButton.setTitle("AC", for: .normal)
        numberButtons.forEach {$0.isEnabled = true}
    }

    // View actions
    @IBAction func touchDigits(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else { return }

        refeshButton.setTitle("C", for: .normal)
        if numberText == "." && displayCalculation.text.isEmpty {
            displayCalculation.text.append("0.")
        } else {
            if numberText == "." {
                if let last = elements.last {
                    if last.contains(".") {
                        alertPopUp(title: "Decimal Error", message: "A dot has already been entered")
                    } else {
                        switch last {
                        case "+", "-", "/", "x", "%":
                            displayCalculation.text.append("0.")
                        default :
                            displayCalculation.text.append(".")
                        }
                    }
                }
            } else {
                displayCalculation.text.append(numberText)
            }
        }
    }

    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        equationDisplay(button: sender, unit: " + ")
    }

    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        equationDisplay(button: sender, unit: " - ")
    }

    @IBAction func tappedDivisionButton(_ sender: UIButton) {
        equationDisplay(button: sender, unit: " / ")
    }

    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        equationDisplay(button: sender, unit: " x ")
    }

    @IBAction func tappedPercentageButton(_ sender: UIButton) {
        equationDisplay(button: sender, unit: " % ")
    }

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        equationButtons.forEach { $0.layer.opacity = 1 }
        numberButtons.forEach { $0.isEnabled = true }

        guard expressionIsCorrect else {
            let alertVC = UIAlertController(title: "Zero!", message: "Enter a correct expression!", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }

        guard expressionHaveEnoughElement else {
            let alertVC = UIAlertController(title: "Zero!", message: "Start a new calculation !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }

        // Create local copy of operations
        var operationsToReduce = elements

        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {

            let calculate = Calculate(operationsToReduce: operationsToReduce)
            let result = calculate.process()

            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            print(result)
            operationsToReduce.insert("\(result)", at: 0)
        }
        resultTextView.text = "\(operationsToReduce[0])"
    }
}

private extension CountViewController {

    func alertPopUp(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }

    func equationDisplay(button: UIButton, unit: String) {
        numberButtons.forEach { $0.isEnabled = true }
        button.layer.opacity = 0.5
        if canAddOperator {
            displayCalculation.text.append(unit)
        } else {
            alertPopUp(title: "Zéro!", message: "Un operateur est déja mis !")
            button.layer.opacity = 1
        }
    }
}
