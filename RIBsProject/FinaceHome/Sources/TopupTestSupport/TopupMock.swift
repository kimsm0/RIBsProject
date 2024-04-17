//
//  File.swift
//  
//
//  Created by kimsoomin_mac2022 on 4/16/24.
//

import Foundation
import Topup

public final class TopupListenerMock: TopupListener {
    public var topupDidCloseCallCount = 0
    public func topupDidClose() {
        topupDidCloseCallCount += 1
    }
    
    public var topupFinishCallCount = 0
    public func topupFinish() {
        topupFinishCallCount += 1
    }
    
    public init(){
        
    }
}
