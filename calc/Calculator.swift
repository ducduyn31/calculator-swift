//
//  Calculator.swift
//  calc
//
//  Created by Jacktator on 31/3/20.
//  Copyright © 2020 UTS. All rights reserved.
//

import Foundation

class Calculator {
    
    func calculate(_ args: [String]) throws -> String {
        guard args.count > 0  || args[0].isNumber() else {
            throw CalculatorError.invalidExpression(suggestedFix: "Please provide a valid expression. Eg: 1 + 1")
        }
        
        
        var valueStack = [args[0].toInt()]
        
        for i in stride(from: 1, to: args.count, by: 2) {
            let operatorSymbol = args[i]
            let nextValue = args[i + 1]
            
            guard nextValue.isNumber() else {
                throw CalculatorError.invalidExpression(suggestedFix: "Please provide a valid expression. Eg: 1 + 1")
            }
            
            if operatorSymbol.isOperator() {
                switch operatorSymbol {
                case "+":
                    valueStack.append(nextValue.toInt())
                case "-":
                    valueStack.append(-nextValue.toInt())
                case "x":
                    valueStack.append(valueStack.removeLast() * nextValue.toInt())
                case "/":
                    guard nextValue.toInt() != 0 else {
                        throw CalculatorError.divideByZero(suggestedFix: "Please provide a non-zero value at \(sliceQuerySample(args, at: i)))")
                    }
                    valueStack.append(valueStack.removeLast() / nextValue.toInt())
                case "%":
                    guard nextValue.toInt() != 0 else {
                        throw CalculatorError.divideByZero(suggestedFix: "Please provide a non-zero value at \(sliceQuerySample(args, at: i)))")
                    }
                    valueStack.append(valueStack.removeLast() % nextValue.toInt())
                default:
                    throw CalculatorError.invalidOperator(suggestedFix: "Please provide a valid operator at \(sliceQuerySample(args, at: i)))")
                }
            } else {
                throw CalculatorError.invalidOperator(suggestedFix: "Please provide a valid operator. Eg: +, -, x, /")
            }
        }
        
        let result = valueStack.reduce(0, +)
        
        return String(Int(result))
    }
    
    private func sliceQuerySample(_ args: [String], at: Int, samples: Int = 2) -> String {
        let start = max(0, at - samples)
        let end = min(args.count, at + samples)
        return Array(args[start..<end]).joined(separator: " ")
    }
}
