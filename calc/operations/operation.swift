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
    let handle: (_ context: inout [Int], _ next: Int) throws -> Void
}

let availableOperations : [BinaryOperation] = [
    BinaryOperation(operatorSymbol: "+", handle: { context, next in
        context.append(next)
    }),
    BinaryOperation(operatorSymbol: "-", handle: { context, next in
        context.append(-next)
    }),
    BinaryOperation(operatorSymbol: "x", handle: { context, next in
        context.append(context.removeLast() * next)
    }),
    BinaryOperation(operatorSymbol: "/", handle: { context, next in
        guard next != 0 else {
            throw CalculatorError.divideByZero(suggestedFix: "Please provide a valid expression. Eg: 1 + 1")
        }
        context.append(context.removeLast() / next)
    }),
    BinaryOperation(operatorSymbol: "%", handle: { context, next in
        context.append(context.removeLast() % next)
    })
]
