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
    @IBOutlet private weak var displayCalculationTextView: UITextView!
    @IBOutlet private var numberButtons: [UIButton]!
    @IBOutlet private var equationButtons: [UIButton]!
    @IBOutlet private weak var  refeshButton: UIButton!
    @IBOutlet private weak var equalButton: UIButton!

    var elements: [String] {
        return displayCalculationTextView.text.split(separator: " ").map { "\($0)" }
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

    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    private func equationDisplay(button: UIButton, unit: String) {
        numberButtons.forEach {$0.isEnabled = true}
        button.layer.opacity = 0.5
        if canAddOperator {
            displayCalculationTextView.text.append(unit)
        } else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
            button.layer.opacity = 1
        }
    }
}

private extension CountViewController {
    @IBAction func refresh() {
        equationButtons.forEach {$0.layer.opacity = 1}
        resultTextView.text = ""
        displayCalculationTextView.text = ""
        refeshButton.setTitle("AC", for: .normal)
        numberButtons.forEach {$0.isEnabled = true}
    }

    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else { return }

        if displayCalculationTextView.text.count >= 6 {
            numberButtons.forEach {$0.isEnabled = false}
        }

        if expressionHaveResult {
            displayCalculationTextView.text = ""
        }
        displayCalculationTextView.text.append(numberText)
        refeshButton.setTitle("C", for: .normal)
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

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        equationButtons.forEach { $0.layer.opacity = 1 }
        numberButtons.forEach { $0.isEnabled = true }

        guard expressionIsCorrect else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Entrez une expression correcte !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }

        guard expressionHaveEnoughElement else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Démarrez un nouveau calcul !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }

        // Create local copy of operations
        var operationsToReduce = elements

        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            let left = Int(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Int(operationsToReduce[2])!

            let calculate = Calculate(left: left, operand: operand, right: right)
            let result = calculate.process()

            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
        }
        resultTextView.text = "\(operationsToReduce[0])"
        refeshButton.setTitle("AC", for: .normal)
    }
}
