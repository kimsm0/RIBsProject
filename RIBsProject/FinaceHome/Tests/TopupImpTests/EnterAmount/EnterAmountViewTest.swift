//
//  File.swift
//  
//
//  Created by kimsoomin_mac2022 on 4/17/24.
//
import XCTest
import Foundation
@testable import TopupImp

import FinanceEntity
import SnapshotTesting

final class EnterAmountViewTest: XCTestCase {
    
    func testEnterAmount(){
        
        let paymentMethod = PaymentMethodModel(id: "0",
                                               name: "우리은행",
                                               digits: "**** 1234",
                                               color: "#51AF80FF",
                                               isPrimary: false
        )
        let viewModel = SelectedPaymentMethodViewModel(paymentMethod)
        let sut = EnterAmountViewController()
        sut.updateSelectedPaymentMethod(with: viewModel)
        assertSnapshots(of: sut, as: [.image])
    }
    
    func testEnterAmountStartLoading(){
        
        let paymentMethod = PaymentMethodModel(id: "0",
                                               name: "우리은행",
                                               digits: "**** 1234",
                                               color: "#51AF80FF",
                                               isPrimary: false
        )
        let viewModel = SelectedPaymentMethodViewModel(paymentMethod)
        let sut = EnterAmountViewController()
        sut.updateSelectedPaymentMethod(with: viewModel)
        sut.startLoading()
        assertSnapshots(of: sut, as: [.image])
    }
    
    func testEnterAmountStopLoading(){
        
        let paymentMethod = PaymentMethodModel(id: "0",
                                               name: "우리은행",
                                               digits: "**** 1234",
                                               color: "#51AF80FF",
                                               isPrimary: false
        )
        let viewModel = SelectedPaymentMethodViewModel(paymentMethod)
        let sut = EnterAmountViewController()
        sut.updateSelectedPaymentMethod(with: viewModel)
        sut.startLoading()
        sut.stopLoading()
        assertSnapshots(of: sut, as: [.image])
    }
}
