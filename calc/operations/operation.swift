//
//  operations_utils.swift
//  calc
//
//  Created by Duy Nguyen on 27/2/2024.
//  Copyright © 2024 UTS. All rights reserved.
//

import Foundation

struct BinaryOperation {
    let operatorSymbol: String
    let apply: (_ context: OperationContext, _ next: Int, _ index: Int) throws -> Void
}

/// Currently supporting +, -, x, /, %, each with a corresponding behavior to the stack
let SupportedOperations : [String:BinaryOperation] = [
    "+": BinaryOperation(operatorSymbol: "+", apply: { context, next, index in
        // an addition add a new element to the addition stack
        context.append(next)
    }),
    "-": BinaryOperation(operatorSymbol: "-", apply: { context, next, index in
        // a subtraction is the same as adding a negative number
        context.append(-next)
    }),
    "x": BinaryOperation(operatorSymbol: "x", apply: { context, next, index in
        // to solve precedence, we need to pop the last element and multiply it with the next element
        context.append(context.removeLast() * next)
    }),
    "/": BinaryOperation(operatorSymbol: "/", apply: { context, next, index in
        guard next != 0 else {
            throw context.buildContextfulError(errorType: .divideByZero, at: index)
        }
        // to solve precedence, we need to pop the last element and divide it by the next element
        context.append(context.removeLast() / next)
    }),
    "%": BinaryOperation(operatorSymbol: "%", apply: { context, next, index in
        guard next != 0 else {
            throw context.buildContextfulError(errorType: .divideByZero, at: index)
        }
        // to solve precedence, we need to pop the last element and modulo it by the next element
        context.append(context.removeLast() % next)
    })
]

extension Dictionary where Key == String, Value == BinaryOperation {
    func matchOperator(_ operatorSymbol: String) throws -> BinaryOperation {
        guard let operation = self[operatorSymbol] else {
            throw ErrorWithMessage(message: "The only supported operators are +, -, x, /, %.")
        }
        return operation
    }
}
