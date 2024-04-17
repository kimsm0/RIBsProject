//
//  File.swift
//  
//
//  Created by kimsoomin_mac2022 on 4/16/24.
//

import Foundation
import FinanceRepository
import CombineUtil
import Combine

public final class SuperPayRepositoryMock: SuperPayRepository {
    
    public var balance: ReadOnlyCurrentValuePublisher<Double> {
        balanceSubject
    }
    public var balanceSubject = CurrentValuePublisher<Double>(0)
    
    
    public var topupCallCount = 0
    public var topupAmount: Double?
    public var paymentMethodID: String?
    public var shouldTopupSucceeed: Bool = true
        
    public init(){
        
    }
    
    public func topup(amount: Double, paymentMethodID: String) -> AnyPublisher<Void, any Error> {
        topupCallCount += 1
        topupAmount = amount
        self.paymentMethodID = paymentMethodID
        
        if shouldTopupSucceeed {
            return Just(()).setFailureType(to: Error.self).eraseToAnyPublisher()
        }else {
            return Fail(error: NSError(domain: "SuperPayRepositoryMock", code: 0)).eraseToAnyPublisher()
        }
    }
}
