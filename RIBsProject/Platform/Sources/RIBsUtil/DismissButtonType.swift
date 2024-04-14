//
//  File.swift
//  
//
//  Created by kimsoomin_mac2022 on 4/14/24.
//

import Foundation

public enum DismissButtonType {
  case back, close
  
  public var iconSystemName: String {
    switch self {
    case .back:
      return "chevron.backward"
    case .close:
      return "xmark"
    }
  }
}
