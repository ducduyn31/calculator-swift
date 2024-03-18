//
//  CalculatorError.swift
//  calc
//
//  Created by Duy Nguyen on 17/2/2024.
//  Copyright © 2024 UTS. All rights reserved.
//

import Foundation

enum CalculatorError: Error, CustomStringConvertible, CaseIterable {
    case invalidArguments
    case invalidOperator
    case invalidNumber
    case invalidExpression
    case divideByZero
    
    var description: String {
        switch self {
        case .invalidArguments:
            return "Invalid Arguments"
        case .invalidOperator:
            return "Invalid Operator"
        case .invalidNumber:
            return "Invalid Number"
        case .invalidExpression:
            return "Invalid Expression"
        case .divideByZero:
            return "Divide by zero"
        }
    }
    
    var subDescription: String {
        switch self {
        case .invalidArguments:
            return "Please provide a valid expression. Eg: 1 + 1"
        case .invalidOperator:
            return "Please provide a valid operator. Eg: +, -, x, /, %"
        case .invalidNumber:
            return "Please provide a valid number"
        case .invalidExpression:
            return "Please provide a valid expression. Eg: 1 + 1"
        case .divideByZero:
            return "Can not divide by zero"
        }
    }
}

struct ErrorWithMessage: Error, CustomStringConvertible {
    let message: String?
    
    var description: String {
        return message ?? self.localizedDescription
    }
}

extension OperationContext {
    
    fileprivate func sliceQuerySample(at: Int, takeOperator: Bool) throws -> (String, String, String) {
        guard at >= 0 && at < self.count else {
            throw ErrorWithMessage(message: "Please provide a valid expression. Eg: 1 + 1")
        }
        
        let (operatorSymbol, number) = self[at]!
        
        var before: [String] = []
        let target = takeOperator ? operatorSymbol : number
        var after: [String] = []
        
        if let beforeElement = self[at - 1] {
            before.append(contentsOf: [beforeElement.0, beforeElement.1])
        }
        
        if let afterElement = self[at + 1] {
            after.append(contentsOf: [afterElement.0, afterElement.1])
        }
        
        if takeOperator {
            after.insert(number, at: 0)
        } else {
            before.append(operatorSymbol)
        }
        
        return (before.joined(separator: " "), target, after.joined(separator: " "))
    }
    
    fileprivate func buildErrorMessage(errorType: CalculatorError, at: Int) -> String {
        
        let (before, error, after) = try! sliceQuerySample(at: at, takeOperator: errorType == .invalidOperator)
        
        return """
        \(errorType)
        \(errorType.subDescription)
        ---
        At index \(at), there is an error with symbol \(error).
        \(before) \(error.withColor(.error)) \(after)
        
        """
    }
    
    
    func buildContextfulError(errorType: CalculatorError, at: Int? = nil, message: String? = nil) -> any Error {
        if message == nil {
            return ErrorWithMessage(message: buildErrorMessage(errorType: errorType, at: at ?? 0))
        }
        return ErrorWithMessage(message: message)
    }
}
