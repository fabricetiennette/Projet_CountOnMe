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

    var result: Double = 0.0

    var elements: [String] {
        return displayCalculation.text.split(separator: " ").map { "\($0)" }
    }

    // Error check computed variables
    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/"
    }

    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }

    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/"
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

        guard expressionHaveEnoughElement else {
            return alertPopUp(title: "Zero!", message: "Start a new calculation !")
        }

        var operationToDo = elements

        if operationToDo.contains(Operator.addition.rawValue) || operationToDo.contains(Operator.substraction.rawValue) {

            guard let left = Double(operationToDo[0]) else { return }
            guard let right = Double(operationToDo[2]) else { return }
            let result = left * right / 100

            resultTextView.text = "\(result)"
        } else if operationToDo.contains(Operator.multiplication.rawValue) || operationToDo.contains(Operator.division.rawValue) {
            let result = 1

            resultTextView.text = "\(result)"
        }
    }

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        equationButtons.forEach { $0.layer.opacity = 1 }
        numberButtons.forEach { $0.isEnabled = true }

        guard expressionIsCorrect else {
            return alertPopUp(title: "Zero!", message: "Enter a correct expression!")
        }

        guard expressionHaveEnoughElement else {
            return alertPopUp(title: "Zero!", message: "Start a new calculation !")
        }

        // Create local copy of operations
        var operationsToReduce = elements

        // Iterate over operations while an operand still here
        while operationsToReduce.contains(Operator.multiplication.rawValue)
            || operationsToReduce.contains(Operator.division.rawValue) {

                let index = operationsToReduce.firstIndex { (element) -> Bool in
                    if let operation = Operator(rawValue: element),
                        operation == .multiplication || operation == .division {
                        return true
                    } else {
                        return false
                    }
                }

                if let index = index {
                    guard let operation = Operator(rawValue: operationsToReduce[index]) else { return }

                    guard let left = Double(operationsToReduce[index - 1]) else { return }
                    guard let right = Double(operationsToReduce[index + 1]) else { return }
                    result = operation.process(left: left, right: right)

                    operationsToReduce.remove(at: index - 1)
                    operationsToReduce.remove(at: index - 1)
                    operationsToReduce.insert("\(result)", at: index)
                    operationsToReduce.remove(at: index - 1)
                }
        }

        // Iterate over operations while an operand still here
        while operationsToReduce.contains(Operator.addition.rawValue)
            || operationsToReduce.contains(Operator.substraction.rawValue) {

                let index = operationsToReduce.firstIndex { (element) -> Bool in
                    if let operation = Operator(rawValue: element),
                        operation == .addition || operation == .substraction || operation == .percentage {
                        return true
                    } else {
                        return false
                    }
                }

                if let index = index {
                    guard let operation = Operator(rawValue: operationsToReduce[index]) else { return }

                    guard let left = Double(operationsToReduce[index - 1]) else { return }
                    guard let right = Double(operationsToReduce[index + 1]) else { return }
                    result = operation.process(left: left, right: right)

                    operationsToReduce.remove(at: index - 1)
                    operationsToReduce.remove(at: index - 1)
                    operationsToReduce.insert("\(result)", at: index)
                    operationsToReduce.remove(at: index - 1)
                }
        }
        resultTextView.text = "\(operationsToReduce.first!)"

//        if let value = operationsToReduce.first,
//            let result = Double(value) {
//
//            let resultString: String
//            if  result.truncatingRemainder(dividingBy: 1.0) == 0 {
//                resultString = String(format: "%.f", result)
//            } else {
//                resultString = String(format: "%.2f", result)
//            }
//            resultTextView.text = "\(resultString)"
//        }
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

        if resultTextView.text != "0" && resultTextView.text != "" {
            displayCalculation.text.removeAll()
            displayCalculation.text += resultTextView.text
            resultTextView.text = ""
        }

        if canAddOperator {
            displayCalculation.text.append(unit)
        } else {
            alertPopUp(title: "Zéro!", message: "Un operateur est déja mis !")
            button.layer.opacity = 1
        }
    }
}
