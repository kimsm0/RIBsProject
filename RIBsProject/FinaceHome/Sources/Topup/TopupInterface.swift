//
//  File.swift
//  
//
//  Created by kimsoomin_mac2022 on 4/15/24.
//

import Foundation
import ModernRIBs

public protocol TopupBuildable: Buildable {
    func build(withListener listener: TopupListener) -> Routing
}

public protocol TopupListener: AnyObject {
    func topupDidClose()
    func topupFinish()
}
