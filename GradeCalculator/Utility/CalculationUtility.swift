//
//  CalculationUtility.swift
//  GradeCalculator
//
//  Created by Hao Li on 2020-08-16.
//  Copyright © 2020 Hao Li. All rights reserved.
//

import Foundation

class CalculationUtility {
    static func summationScore(items: Array<Item>) -> Double {
        return round((items.reduce(0) { $0 + $1.trueScore }) * 10000) / 10000
    }
    
    static func summationPercentage(items: Array<Item>) -> Double {
        return round((items.reduce(0) { $0 + $1.weight }) * 10000) / 10000
    }
    
    static func summationPercentageLost(items: Array<Item>) -> Double {
        return round((items.reduce(0) { $0 + ($1.weight - $1.trueScore) }) * 10000) / 10000
    }
}
