//
//  BaseURL.swift
//  RIBsProject
//
//  Created by kimsoomin_mac2022 on 4/15/24.
//

import Foundation

struct BaseURL {
    var financeBaseURL: URL {
        #if UITESTING
        return URL(string: "https://localhost:8080")!
        #else
        return URL(string: "https://finance.superapp.com/api/v1")!
        #endif
    }
}
