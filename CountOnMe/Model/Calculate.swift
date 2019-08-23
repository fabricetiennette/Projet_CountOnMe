//
//  Calculate.swift
//  CountOnMe
//
//  Created by Fabrice Etiennette on 20/08/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Calculate {

    // MARK: - Properties
    var elements = [String()]
    var operators = ["+"]

    /// Check if the last element is a number and can get a calculation result from it
    var isExpressionCorrect: Bool {
        if let stringNumber = elements.last {
            if stringNumber.isEmpty {
                return false
            }
        }
        return true
    }

    /// Check if there is already an operator
    var canAddOperator: Bool {
        if let last = elements.last {
            if last.isEmpty {
                return false
            }
        }
        return true
    }

    // Check if there is already a dot
    var canAddDecimal: Bool {
        if let last = elements.last {
            if last.contains(".") || last.isEmpty {
                return false
            }
        }
        return true
    }

    // MARK: - CalculatorLogic Methods
    func addDecimal() {
        if let last = elements.last {
            var stringDecimal = last
            stringDecimal += "."
            elements[elements.count - 1] = stringDecimal
        }
    }

    /// This method is used to add a new number for calculation
    func addNewNumber(_ newNumber: String) {
        if let lastNumber = elements.last {
            var stringNumber = lastNumber
            stringNumber += "\(newNumber)"
            elements[elements.count - 1] = stringNumber // Replace last element with the number stored
        }
    }

    // Algorithmic Method for Mathematical Model
    func calculationLogic() -> Double {
        var pendingOperand: Double = 0
        var pendingOperation = ""
        var total: Double = 0

        for (index, item) in elements.enumerated() {
            if let number = Double(item) {
                print("number =  \(number)")
                switch operators[index] {
                case "+":
                    print("bim")
//                    total = performPendingOperation(operand: pendingOperand, operation: pendingOperation, total: total)
                    pendingOperand = total
                    pendingOperation = "+"
                    total = number
                case "-":
                    print("b0m")
//                    total = performPendingOperation(operand: pendingOperand, operation: pendingOperation, total: total)
                    pendingOperand = total
                    pendingOperation = "-"
                    total = number
//                    print("1  = \(total)")
                case "÷":
                    print("biiiiiim")
                    total /= number
                case "×":
                    print("baaaam")
                    print("2 = \(total)")
                    total *= number
                    print("3 = \(total)")
                default:
                    break
                }
            }
        }
        print("4 = \(total)")

        // Perform final pending operation if needed
        total = performPendingOperation(operand: pendingOperand, operation: pendingOperation, total: total)
        print("4 = \(total)")
        return total
    }

    /// This method perform a pending operation ONLY between 2 numbers with operand + or -
    func performPendingOperation(operand: Double, operation: String, total: Double) -> Double {
        switch operation {
        case "+":
            return operand + total
        case "-":
            return operand - total
        default:
            return total
        }
    }

    /// Reset all calculation
    func reset() {
        elements = [String()]
        operators = ["+"]
    }
}
