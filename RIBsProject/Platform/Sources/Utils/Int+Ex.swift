//
//  Int+Ex.swift
//  RIBsProject
//
//  Created by kimsoomin_mac2022 on 4/13/24.
//

import Foundation

public extension Double {
    var decimalFormat: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        guard let priceString = numberFormatter.string(from: NSNumber(value: self)) else {
            return ""
        }
        return priceString
    }
}
