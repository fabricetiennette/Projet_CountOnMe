//
//  Calculate.swift
//  CountOnMe
//
//  Created by Fabrice Etiennette on 20/08/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Calculate {

    enum Operator: String {
        case add = "+"
        case substract = "-"
        case multiply = "x"
        case divide = "÷"
    }

    /// Checking if the expression is correct to preform calculation
    func expressionIsCorrect(elements: [String]) -> Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "÷" && elements.last != "."
    }

    /// Cheking if there is enough elements in the calcul
    func expressionHasEnoughElement(elements: [String]) -> Bool {
        return elements.count >= 3
    }

    /// Check if last element contains a decimal point or is empty
    func isDecimalAddedToLast(elements: [String]) -> Bool {
        return elements.last?.contains(".") ?? false || elements.last?.isEmpty ?? true
    }

    /// Checking if operationToReduce countains operator * and /
    func priorityCalculation(_ operationsToReduce: inout [String]) {
        while operationsToReduce.contains("x") || operationsToReduce.contains("÷") {
            if let index = operationsToReduce.firstIndex(where: {$0 == "x" || $0 == "÷"}), let left = Double(operationsToReduce[index - 1]), let right = Double(operationsToReduce[index + 1]) {
                guard let operand: Operator = Operator(rawValue: operationsToReduce[index]) else { return }
                var result = 0.0

                switch operand {
                case .multiply:
                    result = left * right
                case .divide:
                    result = left / right
                default: break
                }

                checkResult(result: result, index: index - 1, operationsToReduce: &operationsToReduce)

                reducingTheOperation(operationsToReduce: &operationsToReduce, firstIndexToRemove: index + 1, secondIndexToRemove: index)
            }
        }
    }

    /// Calculation + and -
    func nonPriorityCalculation(_ operationsToReduce: inout [String]) {
        if let left = Double(operationsToReduce[0]), let right = Double(operationsToReduce[2]) {
            guard let operand: Operator = Operator(rawValue: operationsToReduce[1]) else { return }
            var result = 0.0

            switch operand {
            case .add:
                result = left + right
            case .substract:
                result = left - right
            default: break
            }

            checkResult(result: result, index: 0, operationsToReduce: &operationsToReduce)

            reducingTheOperation(operationsToReduce: &operationsToReduce, firstIndexToRemove: 2, secondIndexToRemove: 1)
        }
    }

    /// Check if the result can be tranform to Int. Replace the first index of the operation by the result.
    func checkResult(result: Double, index: Int, operationsToReduce: inout [String]) {
        let intValue = round(result)

        if result.isInfinite || result.isNaN {
            operationsToReduce[index] = "Error"
        } else if intValue == result {
            let resultToInt = Int(result)
            operationsToReduce[index] = "\(resultToInt)"
        } else {
            operationsToReduce[index] = "\(result)"
        }
    }

    /// Remove the two index next to operationToReduce.
    func reducingTheOperation(operationsToReduce: inout [String], firstIndexToRemove: Int, secondIndexToRemove: Int) {
        operationsToReduce.remove(at: firstIndexToRemove)
        operationsToReduce.remove(at: secondIndexToRemove)
    }

    /// Format and calculate the total
    func calculate(elements: [String]) -> String? {
        var operationsToReduce = elements

        priorityCalculation(&operationsToReduce)
        while operationsToReduce.count > 1 {
            nonPriorityCalculation(&operationsToReduce)
        }
        return operationsToReduce.first
    }
}
