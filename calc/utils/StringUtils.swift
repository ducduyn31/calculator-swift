//
//  StringUtils.swift
//  calc
//
//  Created by Duy Nguyen on 21/2/2024.
//  Copyright © 2024 UTS. All rights reserved.
//

import Foundation

func isColorSupported() -> Bool {
    return ProcessInfo.processInfo.environment["TERM"] != nil
}


extension String {
    func isNumber() -> Bool {
        return Double(self) != nil
    }
    
    func isOperator() -> Bool {
        return SupportedOperations.keys.contains(self)
    }
    
    func toInt() -> Int {
        return Int(self)!
    }
    
    func withColor(_ color: StringColors) -> String {
        if isColorSupported() {
            return color.rawValue + self + StringColors.reset.rawValue
        }
        return self
    }
}

enum StringColors: String {
    case error = "\u{001B}[0;31m"
    case success = "\u{001B}[0;32m"
    case warning = "\u{001B}[0;33m"
    case reset = "\u{001B}[0;0m"
}
