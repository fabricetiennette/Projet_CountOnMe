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
        return countViewModel.elementsRefactor(from: displayTextView.text)
    }

    // MARK: - Outlets
    @IBOutlet weak private var displayTextView: UITextView!
    @IBOutlet weak private var resultTextView: UITextView!
    @IBOutlet weak private var acButton: UIButton!
}

// MARK: - IBAction
private extension CountViewController {

    // numPadButton is used to add numbers to an array of string for calculation
    @IBAction func numPadButton(_ sender: UIButton) {
        let numberText = countViewModel.displayNumbers(from: sender, of: elements, set: acButton)
        displayTextView.text.append(numberText)
    }

    // decimalButton is used to add decimal. Prevent user to added double decimal points.
    @IBAction func decimalButton(_ sender: UIButton) {
        let text = countViewModel.displayDecimal(on: self, of: elements)
        displayTextView.text.append(text)
    }

    // This method is used to erased the last element
    @IBAction func backSpaceButton() {
        countViewModel.backSpaceKey(displayText: &displayTextView.text, set: acButton)
    }

    // division button
    @IBAction func divisionButton(_ sender: UIButton) {
        let division = countViewModel.unitDisplay(on: self, of: elements, unit: .divide, displayView: &displayTextView.text, resultView: &resultTextView.text)
        displayTextView.text.append(division)
    }

    // multiplication button
    @IBAction func multiplicationButton(_ sender: UIButton) {
        let multiply = countViewModel.unitDisplay(on: self, of: elements, unit: .multiply, displayView: &displayTextView.text, resultView: &resultTextView.text)
        displayTextView.text.append(multiply)
    }

    // addition button
    @IBAction func additionButton() {
        let add = countViewModel.unitDisplay(on: self, of: elements, unit: .add, displayView: &displayTextView.text, resultView: &resultTextView.text)
        displayTextView.text.append(add)
    }

    // substraction button
    @IBAction func substractionButton() {
        let substract = countViewModel.unitDisplay(on: self, of: elements, unit: .substract, displayView: &displayTextView.text, resultView: &resultTextView.text)
        displayTextView.text.append(substract)
    }

    /// resultButton check if there is a correct equation for calculate and do the calculation
    @IBAction func resultButton() {
        countViewModel.getResult(on: self, of: elements, resultText: &resultTextView.text)
    }

    // resetButton aka AC button reset all textView
    @IBAction func resetButton(_ sender: UIButton) {
        countViewModel.clearAll(set: sender, disPlayText: &displayTextView.text, resultText: &resultTextView.text)
    }
}
