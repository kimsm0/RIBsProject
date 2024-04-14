//
//  AddPaymentMethodInfo.swift
//  RIBsProject
//
//  Created by kimsoomin_mac2022 on 4/13/24.
//

import Foundation

public struct AddPaymentMethodInfo {
    public let numnber: String
    public let cvs: String
    public let expiration: String
    
    public init(numnber: String, 
         cvs: String,
         expiration: String
    ) {
        self.numnber = numnber
        self.cvs = cvs
        self.expiration = expiration
    }
}
