//
//  CardOnFileReposistory.swift
//  RIBsProject
//
//  Created by kimsoomin_mac2022 on 4/13/24.
//

import Foundation
import Combine
import FinanceEntity
import CombineUtil

public protocol CardOnFileReposistory {
    var cardOnfFile: ReadOnlyCurrentValuePublisher<[PaymentMethodModel]> { get }
    func addCard(info: AddPaymentMethodInfo) -> AnyPublisher<PaymentMethodModel, Error>
}

public final class CardOnFileReposistoryImp: CardOnFileReposistory{
        
    public init(){
        
    }
    public var cardOnfFile: ReadOnlyCurrentValuePublisher<[PaymentMethodModel]>{
        paymentMethodsubject
    }
    private let paymentMethodsubject = CurrentValuePublisher<[PaymentMethodModel]>([
//        PaymentMethodModel(id: "0", name: "우리은행", digits: "0123", color: "#f19a38ff", isPrimary: true),
//        PaymentMethodModel(id: "1", name: "신한은행", digits: "1234", color: "#3478f6ff", isPrimary: false),
//        PaymentMethodModel(id: "2", name: "국민은행", digits: "2345", color: "#78c5f5ff", isPrimary: false),
//        PaymentMethodModel(id: "3", name: "농협", digits: "3456", color: "#65c466ff", isPrimary: false),
//        PaymentMethodModel(id: "4", name: "현대카드", digits: "4567", color: "#ffcc00ff", isPrimary: false),
//        PaymentMethodModel(id: "3", name: "농협", digits: "3456", color: "#65c466ff", isPrimary: false),
//        PaymentMethodModel(id: "4", name: "현대카드", digits: "4567", color: "#ffcc00ff", isPrimary: false)
    ])
    
    public func addCard(info: AddPaymentMethodInfo) -> AnyPublisher<PaymentMethodModel, Error> {
        let newCardModel = PaymentMethodModel(id: "00", name: "NEW 카드", digits: "\(info.numnber.suffix(4))", color: "#65c466ff", isPrimary: false)
        
        var new = paymentMethodsubject.value
        new.insert(newCardModel, at: 0)
        paymentMethodsubject.send(new)
        
        return Just(newCardModel)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
}
