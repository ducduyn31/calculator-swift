//
//  StringUtils.swift
//  calc
//
//  Created by Duy Nguyen on 21/2/2024.
//  Copyright © 2024 UTS. All rights reserved.
//

import Foundation


extension String {
    func isNumber() -> Bool {
        return Double(self) != nil
    }
    
    func isOperator() -> Bool {
        return ["+", "-", "x", "/", "%"].contains(self)
    }
    
    func toInt() -> Int {
        return Int(self)!
    }
}
