//
//  SetupURLProtocol.swift
//  RIBsProject
//
//  Created by kimsoomin_mac2022 on 4/15/24.
//

import Foundation

func setupURLProtocol(){
    // MARK:
    let topupResponse: [String: Any] = [
        "status": "success"
    ]
    
    let topupResponseData = try! JSONSerialization.data(withJSONObject: topupResponse, options: [])
    
    
    // MARK:
    let addCardResponse: [String: Any] = [
        "card": [
            "id": "999",
            "name": "새 카드",
            "digits": "**** 0101",
            "color": "#65c466ff",
            "isPrimary": false
        ]
    ]
    
    let addCardResponseData = try! JSONSerialization.data(withJSONObject: addCardResponse, options: [])
    
    
    
    // MARK:
    let cardOnFileResponse: [String: Any] = [
        "cards": [
            [
            "id": "0",
            "name": "우리은행",
            "digits": "**** 0123",
            "color": "#3478f6ff",
            "isPrimary": false
            ],
            [
            "id": "1",
            "name": "신한은행",
            "digits": "**** 0123",
            "color": "#78c5f5ff",
            "isPrimary": false
            ],
            [
            "id": "2",
            "name": "국민은행",
            "digits": "**** 0123",
            "color": "#65c466ff",
            "isPrimary": false
            ]
        ]
    ]
    
    let cardOnFileResponseData = try! JSONSerialization.data(withJSONObject: cardOnFileResponse, options: [])
    
    RIBsProjectAppURLProtocol.successMock = [
        "/api/v1/topup": (200, topupResponseData),
        "/api/v1/addCard": (200, addCardResponseData),
        "/api/v1/cards": (200, cardOnFileResponseData)
    ]
}
