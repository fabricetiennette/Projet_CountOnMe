//
//  Calculate.swift
//  CountOnMe
//
//  Created by Fabrice Etiennette on 20/08/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Calculate {
    let left: Int
    let operand: String
    let right: Int
    
    init(left: Int, operand: String, right: Int) {
        self.left = left
        self.operand = operand
        self.right = right
    }
    
    func process() -> Int {
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
        return result
    }
}
