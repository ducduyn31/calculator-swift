//
//  context.swift
//  calc
//
//  Created by Duy Nguyen on 18/3/2024.
//  Copyright © 2024 UTS. All rights reserved.
//

import Foundation


class OperationContext {
    
    private var valueStack: [Int]
    private var queryArgs: [String]
    
    var count: Int {
        get {
            if self.queryArgs.count == 1 {
                return 1
            }
            return self.queryArgs.count / 2 + 1
        }
    }
    
    
    init(initialValues: [Int], queryArgs: [String]) {
        self.valueStack = initialValues
        self.queryArgs = queryArgs
    }
    
    convenience init(queryArgs: [String]) {
        // First argument should always be a number
        self.init(initialValues: queryArgs.count > 0 ? [queryArgs[0].toInt()] : [], queryArgs: queryArgs)
    }
    
    /// Get the pair of operator and number at the given index
    ///
    /// The index is different from the queryArgs index, it is calculated by the formula `index = queryArgsIndex / 2`, except for the first pair which has index 0
    ///
    ///         var queryArgs = ["1", "+", "2", "x", "3", "/", "4"]
    ///         let context = OperationContext(queryArgs: queryArgs)
    ///         print(context[0]) // ("", "1")
    ///         print(context[1]) // ("+", "2")
    ///         print(context[2]) // ("x", "3")
    ///
    ///
    /// - Parameter index: The index of the pair
    /// - Returns: A tuple of operator and number
    /// - Complexity: O(1)
    subscript(index: Int) -> (String, String)? {
        let queryArgsIndex = index * 2 - 1
        if queryArgsIndex >= self.queryArgs.count - 1 || index < 0 {
            return nil
        }
        if index == 0 {
            return ("", self.queryArgs[0])
        }
        return (self.queryArgs[queryArgsIndex], self.queryArgs[queryArgsIndex + 1])
    }
    
    /// Iterate through the queryArgs and extract pairs of operator and number
    ///
    /// The first pair is always a number, and the rest are operator-number pairs
    /// - Parameter skipFirst: Whether to skip the first pair, which is always a number
    /// - Returns: An iterator that yields pairs of operator and number
    /// - Complexity: O(1)
    func operationIterator(skipFirst: Bool = true) -> QueryIterator {
        return QueryIterator(queryArgs: self.queryArgs, skipFirst: skipFirst)
    }
    
    func getResult() -> String {
        return self.valueStack.isEmpty ? "No result" : String(self.valueStack.reduce(0, +))
    }
    
    func append(_ value: Int) {
        self.valueStack.append(value)
    }
    
    func removeLast() -> Int {
        return self.valueStack.removeLast()
    }
    
    struct QueryIterator: IteratorProtocol, Sequence {
        private var queryArgs: [String]
        private var index: Int
        
        init(queryArgs: [String], skipFirst: Bool) {
            self.queryArgs = queryArgs
            self.index = skipFirst ? 1 : 0
        }
        
        mutating func next() -> (Int, String, String)? {
            let queryArgsIndex = index * 2 - 1
            if queryArgsIndex >= self.queryArgs.count - 1 {
                return nil
            }
            if index == 0 {
                index += 1
                return (0, "", self.queryArgs[0])
            }
            let result = (index, self.queryArgs[queryArgsIndex], self.queryArgs[queryArgsIndex + 1])
            index += 1
            return result
        }
    }
}
