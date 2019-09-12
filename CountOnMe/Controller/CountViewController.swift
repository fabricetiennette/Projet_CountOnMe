//
//  CountController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class CountViewController: UIViewController {

    /// Instance of CountViewModel
    let countViewModel = CountViewModel()

    /// elements is an array for string 
    private var elements: [String] {
        return countViewModel.makeElements(from: displayTextView.text)
    }

    // MARK: - Outlets
    @IBOutlet weak private var displayTextView: UITextView!
    @IBOutlet weak private var resultTextView: UITextView!
    @IBOutlet weak private var acButton: UIButton!
}

// MARK: - IBAction
private extension CountViewController {

    // numPadButton is used to add numbers to an array for string for calculation
    @IBAction func numPadButton(_ sender: UIButton) {
        let numberText = countViewModel.displayNumbers(from: sender, elements: elements, acButton: acButton)
        displayTextView.text.append(numberText)
    }

    // decimalButton is used to add decimal. Prevent also also double decimal.
    @IBAction func decimalButton(_ sender: UIButton) {
        let text = countViewModel.displayDecimal(on: self, elements: elements)
        displayTextView.text.append(text)
    }

    // This method is used to erased the last element
    @IBAction func backSpace() {
        countViewModel.eraseLast(displayText: &displayTextView.text, acButton: acButton)
    }

    // division button
    @IBAction func divisionButton(_ sender: UIButton) {
        let division = countViewModel.unitDisplay(on: self, elements: elements, unit: .divide, displayView: &displayTextView.text, resultView: &resultTextView.text)
        displayTextView.text.append(division)
    }

    // multiplication button
    @IBAction func multiplicationButton(_ sender: UIButton) {
        let multiply = countViewModel.unitDisplay(on: self, elements: elements, unit: .multiply, displayView: &displayTextView.text, resultView: &resultTextView.text)
        displayTextView.text.append(multiply)
    }

    // addition button
    @IBAction func additionButton() {
        let add = countViewModel.unitDisplay(on: self, elements: elements, unit: .add, displayView: &displayTextView.text, resultView: &resultTextView.text)
        displayTextView.text.append(add)
    }

    // substraction button
    @IBAction func substractionButton() {
        let substract = countViewModel.unitDisplay(on: self, elements: elements, unit: .substract, displayView: &displayTextView.text, resultView: &resultTextView.text)
        displayTextView.text.append(substract)
    }

    /// resultButton check if there is a correct equation for calculate and do the calculation
    @IBAction func resultButton() {
        countViewModel.getResult(on: self, elements: elements, resultText: &resultTextView.text)
    }

    // resetButton aka AC button reset all textView
    @IBAction func resetButton(_ sender: UIButton) {
        countViewModel.clearAll(acButton: sender, disPlayText: &displayTextView.text, resultText: &resultTextView.text)
    }
}
