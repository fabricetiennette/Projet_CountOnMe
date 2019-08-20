//
//  Calculate.swift
//  CountOnMe
//
//  Created by Fabrice Etiennette on 20/08/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Calculate {
    var operationsToReduce: [String]

    init(operationsToReduce: [String]) {
        self.operationsToReduce = operationsToReduce
    }

    func process() -> Double {
        let left = Double(operationsToReduce[0])!
        let operand = operationsToReduce[1]
        let right = Double(operationsToReduce[2])!
        let result: Double
        switch operand {
        case "+":
            result = left + right
        case "-":
            result = left - right
        case "/":
            result = left / right
        case "x":
            result = left * right
        case "%":
            result = right * left / 100
        default: fatalError("Unknown operator !")
        }
        return result
    }
}
