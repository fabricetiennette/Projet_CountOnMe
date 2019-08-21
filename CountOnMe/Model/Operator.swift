//
//  Operator.swift
//  CountOnMe
//
//  Created by Fabrice Etiennette on 20/08/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import Foundation

enum Operator: String, CaseIterable, RawRepresentable {
    case multiplication = "x"
    case division = "/"
    case addition = "+"
    case substraction = "-"
    case percentage
}

extension Operator {
    func process(left: Double, right: Double) -> Double {
        switch self {
        case .addition:
            return left + right
        case .substraction:
            return left - right
        case .division:
            return left / right
        case .multiplication:
            return left * right
        case .percentage:
            return left * right / 100
        }
    }
}
