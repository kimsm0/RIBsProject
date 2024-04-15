//
//  SuperPayRepository.swift
//  RIBsProject
//
//  Created by kimsoomin_mac2022 on 4/13/24.
//

import Foundation
import Combine
import CombineUtil
import Network

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
    
    private let network: Network
    private let baseURL: URL
    
    public init(network: Network, baseURL: URL){
        self.network = network
        self.baseURL = baseURL
    }
}

extension SuperPayRepositoryImp {
    public func topup(amount: Double, paymentMethodID: String) -> AnyPublisher<Void, any Error> {
        let request = TopupRequest(baseURL: baseURL, amount: amount, paymentMethodID: paymentMethodID)
        return network
            .send(request)
            .handleEvents(receiveSubscription: {[weak self] _ in
                let newBalance = (self?.balanceSuject.value).map { $0 + amount }
                newBalance.map { self?.balanceSuject.send($0) }
            },
              receiveOutput: nil,
              receiveCompletion: nil,
              receiveCancel: nil,
              receiveRequest: nil)
            .map({_ in  })
            .eraseToAnyPublisher()
//        return Future<Void, Error> { [weak self] promise in
//            self?.bgQueue.async {
//                Thread.sleep(forTimeInterval: 2)
//                promise(.success(()))
//                let newBalance = (self?.balance.value).map{ $0 + amount }
//                newBalance.map { self?.balanceSuject.send($0) }
//            }
//        }.eraseToAnyPublisher()
    }
}
