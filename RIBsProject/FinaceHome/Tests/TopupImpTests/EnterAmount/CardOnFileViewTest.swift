//
//  File.swift
//  
//
//  Created by kimsoomin_mac2022 on 4/17/24.
//

import Foundation
import XCTest
import Foundation
@testable import TopupImp

import FinanceEntity
import SnapshotTesting

final class CardOnFileViewTest: XCTestCase {
    
    
    func testCardOnFile(){
        
        let cards = [PaymentMethodModel(id: "test_id1",
                                               name: "test_name",
                                               digits: "test_1234",
                                               color: "#13ABE8FF",
                                               isPrimary: false),
                             PaymentMethodModel(id: "test_id2",
                                                name: "test_name2",
                                                digits: "test_12345678",
                                                color: "#13ABE8FF",
                                                isPrimary: false)
        ]
        
        let sut = CardOnFileViewController()
        
        sut.update(with: cards.map(PaymentMethodViewModel.init))
        
        assertSnapshots(of: sut, as: [.image])
    }
    
}
