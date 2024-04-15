//
//  File.swift
//  
//
//  Created by kimsoomin_mac2022 on 4/15/24.
//

import Foundation
import ModernRIBs

public protocol TransportHomeBuildable: Buildable {
  func build(withListener listener: TransportHomeListener) -> ViewableRouting
}
public protocol TransportHomeListener: AnyObject {
  func transportHomeDidTapClose()
}
