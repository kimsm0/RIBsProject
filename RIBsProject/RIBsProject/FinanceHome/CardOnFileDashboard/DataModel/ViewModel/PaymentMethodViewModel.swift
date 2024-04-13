//
//  PaymentMethodViewModel.swift
//  RIBsProject
//
//  Created by kimsoomin_mac2022 on 4/13/24.
//

import UIKit

struct PaymentMethodViewModel {
    let name: String
    let digits: String
    let color: UIColor
    
    init(_ dto: PaymentMethodModel) {
        name = dto.name
        digits = "**** \(dto.digits)"
        color = UIColor(hex: dto.color) ?? .systemGray2
    }
}

