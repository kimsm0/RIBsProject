//
//  CombineUtil.swift
//  RIBsProject
//
//  Created by kimsoomin_mac2022 on 4/13/24.
//

import Foundation
import Combine
import CombineExt

/*
 Current Value Subject의 변경
 구독자들이 가장 최신값을 받을 수 있게 하되, 직접 값을 send 할 수는 없다. 
 */
public class ReadOnlyCurrentValuePublisher<Element>: Publisher {
    public typealias Output = Element
    public typealias Failure = Never
    
    public var value: Element {
        currentValueRelay.value
    }
    
    fileprivate let currentValueRelay: CurrentValueRelay<Output>
    fileprivate init(_ initialValue: Element){
        currentValueRelay = CurrentValueRelay(initialValue)
    }
    
    public func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, Element == S.Input {
        currentValueRelay.receive(subscriber: subscriber)
    }
}

public final class CurrentValuePublisher<Element>: ReadOnlyCurrentValuePublisher<Element> {
    public typealias Output = Element
    public typealias Failure = Never
    
    public override init(_ initialValue: Element){
        super.init(initialValue)
    }
    
    public func send(_ value: Element){
        currentValueRelay.accept(value)
    }
}
