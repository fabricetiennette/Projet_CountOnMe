//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    @IBOutlet var equationButtons: [UIButton]!
    @IBOutlet weak var  refeshButton: UIButton!
    @IBOutlet weak var equalButton: UIButton!
    
    var elements: [String] {
        return textView.text.split(separator: " ").map { "\($0)" }
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
        return textView.text.firstIndex(of: "=") != nil
    }
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func refesh() {
        equationButtons.forEach {$0.layer.opacity = 1}
        textView.text = ""
        refeshButton.setTitle("AC", for: .normal)
        numberButtons.forEach {$0.isEnabled = true}
    }
    
    
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else { return }
        
        
        if textView.text.count >= 6 {
            numberButtons.forEach {$0.isEnabled = false}
        }
        if textView.text == "0" {
            textView.text = ""
        }
        
        if expressionHaveResult {
            textView.text = ""
        }
        textView.text.append(numberText)
        refeshButton.setTitle("C", for: .normal)
    }
    
    private func equationDisplay(button: UIButton, unit: String) {
        numberButtons.forEach {$0.isEnabled = true}
        button.layer.opacity = 0.5
        if canAddOperator {
            textView.text.append(unit)
        } else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
            button.layer.opacity = 1
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

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        equationButtons.forEach {$0.layer.opacity = 1}
        numberButtons.forEach {$0.isEnabled = true}

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
            
            let result: Int
            switch operand {
            case "+":
                result = left + right
            case "-":
                result = left - right
            case "/":
                result = left / right
            case "x":
                result = left * right
            default: fatalError("Unknown operator !")
            }
            
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
        }
        textView.text = "\(operationsToReduce[0])"
        refeshButton.setTitle("AC", for: .normal)
    }
}
