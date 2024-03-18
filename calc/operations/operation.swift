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

let SupportedOperations : [String:BinaryOperation] = [
    "+": BinaryOperation(operatorSymbol: "+", apply: { context, next, index in
        context.append(next)
    }),
    "-": BinaryOperation(operatorSymbol: "-", apply: { context, next, index in
        context.append(-next)
    }),
    "x": BinaryOperation(operatorSymbol: "x", apply: { context, next, index in
        context.append(context.removeLast() * next)
    }),
    "/": BinaryOperation(operatorSymbol: "/", apply: { context, next, index in
        guard next != 0 else {
            throw context.buildContextfulError(errorType: .divideByZero, at: index)
        }
        context.append(context.removeLast() / next)
    }),
    "%": BinaryOperation(operatorSymbol: "%", apply: { context, next, index in
        guard next != 0 else {
            throw context.buildContextfulError(errorType: .divideByZero, at: index)
        }
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
