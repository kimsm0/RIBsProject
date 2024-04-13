//
//  PaymentModel.swift
//  RIBsProject
//
//  Created by kimsoomin_mac2022 on 4/13/24.
//

import Foundation

struct PaymentMethodModel: Decodable {
    let id: String
    let name: String
    let digits: String
    let color: String
    let isPrimary: Bool
}
