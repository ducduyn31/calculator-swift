//
//  CalculatorError.swift
//  calc
//
//  Created by Duy Nguyen on 17/2/2024.
//  Copyright © 2024 UTS. All rights reserved.
//

import Foundation

enum CalculatorError: Error, CustomStringConvertible {
    case invalidArguments(suggestedFix: String? = nil)
    case invalidOperator(suggestedFix: String? = nil)
    case invalidNumber(suggestedFix: String? = nil)
    case invalidExpression(suggestedFix: String? = nil)
    
    var description: String {
        switch self {
        case .invalidArguments(let suggestedFix):
            return "Invalid arguments. \(suggestedFix ?? "")"
        case .invalidOperator(let suggestedFix):
            return "Invalid operator. \(suggestedFix ?? "")"
        case .invalidNumber(let suggestedFix):
            return "Invalid number. \(suggestedFix ?? "")"
        case .invalidExpression(let suggestedFix):
            return "Invalid expression. \(suggestedFix ?? "")"
        }
    }
}
