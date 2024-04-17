//
//  File.swift
//  
//
//  Created by kimsoomin_mac2022 on 4/16/24.
//

import Foundation
import FinanceRepository
import FinanceEntity
import CombineUtil
import Combine


public final class CardOnFileRepositoryMock: CardOnFileReposistory {
    
    public var cardOnfFile: ReadOnlyCurrentValuePublisher<[PaymentMethodModel]> { cardOnFileSubject }
    public var cardOnFileSubject: CurrentValuePublisher<[PaymentMethodModel]> = .init([])
        
    
    public var addCardCallCount = 0
    public var addCardInfo: AddPaymentMethodInfo?
    public var addedPaymentMethod: PaymentMethodModel?
    
    public func addCard(info: AddPaymentMethodInfo) -> AnyPublisher<PaymentMethodModel, any Error> {
        addCardCallCount += 1
        addCardInfo = info
        
        if let addedPaymentMethod = addedPaymentMethod {
            return Just(addedPaymentMethod).setFailureType(to: Error.self).eraseToAnyPublisher()
        }else {
            return Fail(error: NSError(domain: "CardOnFile", code: 0)).eraseToAnyPublisher()
        }
    }
    
    public var fetchCallCount = 0
    public func fetch() {
        fetchCallCount += 1
    }
    
    public init(){
        
    }
    
}
