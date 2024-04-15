//
//  PaymentMethodViewModel.swift
//  RIBsProject
//
//  Created by kimsoomin_mac2022 on 4/13/24.
//

import UIKit
import SuperUI

public struct PaymentMethodViewModel {
    public let name: String
    public let digits: String
    public let color: UIColor
    
    public init(_ dto: PaymentMethodModel) {
        name = dto.name
        digits = "**** \(dto.digits)"
        color = UIColor(hex: dto.color) ?? .systemGray2
    }
}

