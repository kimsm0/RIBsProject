//
//  File.swift
//  
//
//  Created by kimsoomin_mac2022 on 4/15/24.
//

import Foundation
import ModernRIBs
import FinanceEntity
import RIBsUtil

public protocol AddPaymentMethodBuildable: Buildable {
    
    func build(withListener listener: AddPaymentMethodListener, closeButtonType: DismissButtonType) -> ViewableRouting
}
public protocol AddPaymentMethodListener: AnyObject {
    func addPaymentMethodTapClose()
    func addPaymentMethodDidAddCard(paymentMethod: PaymentMethodModel)
}
