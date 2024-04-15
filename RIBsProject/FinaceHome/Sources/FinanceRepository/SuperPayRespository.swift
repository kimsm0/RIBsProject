//
//  SuperPayRepository.swift
//  RIBsProject
//
//  Created by kimsoomin_mac2022 on 4/13/24.
//

import Foundation
import Combine
import CombineUtil

public protocol SuperPayRepository {
    var balance: ReadOnlyCurrentValuePublisher<Double> { get }
    func topup(amount: Double, paymentMethodID: String) -> AnyPublisher<Void, Error>
}

public final class SuperPayRepositoryImp: SuperPayRepository {
    public var balance: ReadOnlyCurrentValuePublisher<Double> {
        balanceSuject
    }
    
    private let balanceSuject = CurrentValuePublisher<Double>(0)
    
    private let bgQueue = DispatchQueue(label: "topup")
    
    public init(){
        
    }
}

extension SuperPayRepositoryImp {
    public func topup(amount: Double, paymentMethodID: String) -> AnyPublisher<Void, any Error> {
        return Future<Void, Error> { [weak self] promise in
            self?.bgQueue.async {
                Thread.sleep(forTimeInterval: 2)
                promise(.success(()))
                let newBalance = (self?.balance.value).map{ $0 + amount }
                newBalance.map { self?.balanceSuject.send($0) }
            }
        }.eraseToAnyPublisher()
    }
}
