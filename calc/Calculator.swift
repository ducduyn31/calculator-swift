//
//  Calculator.swift
//  calc
//
//  Created by Jacktator on 31/3/20.
//  Copyright © 2020 UTS. All rights reserved.
//

import Foundation

class Calculator {
    
    /// Calculate the result of the expression
    /// - Parameter args: The expression to calculate
    /// - Throws: An error if the expression is invalid
    func calculate(_ args: [String]) throws -> String {
        try throwIfInvalidExpression(args)
        
        // Create a context to store the information required for the calculation
        // Most importantly, an addition stack to store the numbers and the operators
        let context = OperationContext(queryArgs: args)
        
        // Iterate through the operators only, and apply the operations to the stack
        for (index, operatorSymbol, nextValue) in context.operationIterator() {
            try throwIfOperatorAndValueInvalid(index, context)
            
            try SupportedOperations
                .matchOperator(operatorSymbol)
                .apply(context, nextValue.toInt(), index)
        }
        
        return context.getResult()
    }
    
    /// Throws an error if the operator and value are invalid: expecting an operator and a number at the correct index
    fileprivate func throwIfOperatorAndValueInvalid(_ index: Int, _ context: OperationContext) throws {
        let (operatorSymbol, nextValue) = context[index] ?? (nil, nil)
        
        guard let operatorSymbol = operatorSymbol, let nextValue = nextValue else {
            return
        }
        
        if !operatorSymbol.isOperator() {
            throw context.buildContextfulError(errorType: .invalidOperator, at: index)
        }
        
        if !nextValue.isNumber() {
            throw context.buildContextfulError(errorType: .invalidNumber, at: index)
        }
    }
    
    /// Throws an error if the expression is invalid: not enough arguments or the first argument is not a number
    fileprivate func throwIfInvalidExpression(_ args: [String]) throws {
        guard args.count > 0 && args.count.isOdd() && args[0].isNumber() else {
            throw ErrorWithMessage(message: "Please provide a valid expression. Eg: 1 + 1")
        }
    }
}
