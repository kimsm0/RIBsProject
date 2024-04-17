//
//  File.swift
//  
//
//  Created by kimsoomin_mac2022 on 4/16/24.
//

import Foundation
import CombineUtil
import FinanceEntity
import FinanceRepository
import FinanceRepositoryTestSupport
import CombineSchedulers

@testable import TopupImp

final class EnterAmountPresentableMock: EnterAmountPresentable {
    var listener: EnterAmountPresentableListener?
    
    public var updateSelectedPaymentMethodCallCount = 0
    public var updateSelectedPaymentMethodViewModel: SelectedPaymentMethodViewModel?
    
    func updateSelectedPaymentMethod(with viewModel: SelectedPaymentMethodViewModel) {
    
        updateSelectedPaymentMethodCallCount += 1
        updateSelectedPaymentMethodViewModel = viewModel
    }
    
    public var startLoadingCallCount = 0
    func startLoading() {
        startLoadingCallCount += 1
    }
    
    public var stopLoadingCallCount = 0
    func stopLoading() {
        stopLoadingCallCount += 1
    }
    
    init(){
        
    }
}

final class EnterAmountDepengencyMock: EnterAmountInteractorDependency {
    var mainQueue: AnySchedulerOf<DispatchQueue> { .immediate }
    
    var selectedpaymentMethodSubject =  CurrentValuePublisher<PaymentMethodModel>(
        PaymentMethodModel(id: "", name: "", digits: "", color: "", isPrimary: false)
    )
    var selectedpaymentMethod: ReadOnlyCurrentValuePublisher<PaymentMethodModel>{
        selectedpaymentMethodSubject
    }
    var superPayRepository: SuperPayRepository = SuperPayRepositoryMock()
    
    
}


final class EnterAmountListenerMock: EnterAmountListener {
    
    var enterAmountDidTapCloseCallCount = 0
    func enterAmountDidTapClose() {
        enterAmountDidTapCloseCallCount += 1
    }
        
    var enterAmountDidTapPaymentMethodCallCount = 0
    func enterAmountDidTapPaymentMethod() {
        enterAmountDidTapPaymentMethodCallCount += 1
    }
    
    var enterAmountDidFinishTopupCallCount = 0
    func enterAmountDidFinishTopup() {
        enterAmountDidFinishTopupCallCount += 1
    }
}
