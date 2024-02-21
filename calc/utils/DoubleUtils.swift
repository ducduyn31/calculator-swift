//
//  DoubleUtils.swift
//  calc
//
//  Created by Duy Nguyen on 21/2/2024.
//  Copyright © 2024 UTS. All rights reserved.
//

import Foundation

extension Double {
    func isInteger() -> Bool {
        return floor(self) == self
    }
}
