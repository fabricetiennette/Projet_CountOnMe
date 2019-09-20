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
        let (numberText, acButtonTitle) = countViewModel.displayNumbers(
            from: sender.title(for: .normal),
            of: elements
        )
        acButton.setTitle(acButtonTitle, for: .normal)
        displayTextView.text.append(numberText)
    }

    // decimalButton is used to add decimal. Prevent user to added double decimal points.
    @IBAction func decimalButton(_ sender: UIButton) {
        let text = countViewModel.displayDecimal(of: elements)
        displayTextView.text.append(text)
    }

    // This method is used to erased the last element
    @IBAction func backSpaceButton() {
        let (text, title) = countViewModel.eraseButtonTapped(displayText: displayTextView.text)
        displayTextView.text = text
        acButton.setTitle(title, for: .normal)
    }

    // division button
    @IBAction func divisionButton(_ sender: UIButton) {
        let (division, text, resultView) = countViewModel.unitDisplay(
            of: elements,
            unit: .divide,
            displayView: displayTextView.text,
            resultView: resultTextView.text
        )
        displayTextView.text = text
        resultTextView.text = resultView
        displayTextView.text.append(division)
    }

    // multiplication button
    @IBAction func multiplicationButton(_ sender: UIButton) {
        let (multiply, text, resultView) = countViewModel.unitDisplay(
            of: elements,
            unit: .multiply,
            displayView: displayTextView.text,
            resultView: resultTextView.text
        )
        displayTextView.text = text
        resultTextView.text = resultView
        displayTextView.text.append(multiply)
    }

    // addition button
    @IBAction func additionButton() {
        let (add, text, resultView) = countViewModel.unitDisplay(
            of: elements,
            unit: .add,
            displayView: displayTextView.text,
            resultView: resultTextView.text
        )
        displayTextView.text = text
        resultTextView.text = resultView
        displayTextView.text.append(add)
    }

    // substraction button
    @IBAction func substractionButton() {
        let (substract, text, resultView) = countViewModel.unitDisplay(
            of: elements,
            unit: .substract,
            displayView: displayTextView.text,
            resultView: resultTextView.text
        )
        displayTextView.text = text
        resultTextView.text = resultView
        displayTextView.text.append(substract)
    }

    /// resultButton check if there is a correct equation for calculate and do the calculation
    @IBAction func resultButton() {
        let result = countViewModel.getResult(of: elements, resultText: resultTextView.text)
        resultTextView.text = result
    }

    // resetButton aka AC button reset all textView
    @IBAction func resetButton(_ sender: UIButton) {
        let (clearText, backToZero, acButtonTitle) = countViewModel.clearAll()
        acButton.setTitle(acButtonTitle, for: .normal)
        displayTextView.text = clearText
        resultTextView.text = backToZero
    }
}
