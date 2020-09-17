//
//  UITextViewUtility.swift
//  GradeCalculator
//
//  Created by Hao Li on 2020-09-09.
//  Copyright © 2020 Hao Li. All rights reserved.
//

import UIKit

extension UITextField {
    public func getValueByDouble() -> Double {
        return Double(self.text ?? "") ?? 0.0
    }
    public func getUnwrappedText() -> String {
        return self.text ?? ""
    }
}
