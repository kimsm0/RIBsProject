//
//  File.swift
//  
//
//  Created by kimsoomin_mac2022 on 4/16/24.
//

import Foundation
@testable import TopupImp
import CombineUtil
import FinanceEntity
import FinanceRepositoryTestSupport
import FinanceRepository
import Topup
import ModernRIBs
import RIBsUtil
import Combine
import SuperUI

final class TopupDepengencyMock: TopupInteractorDependency {
    
    var cardOnFileRepository: CardOnFileReposistory = CardOnFileRepositoryMock()
    var paymentMethodStream: CurrentValuePublisher<PaymentMethodModel> = .init(PaymentMethodModel.init(id: "", name: "", digits: "", color: "", isPrimary: false))
    
    
}
final class TopupRoutingMock: TopupRouting {
  
  var attachAddPaymentMethodCallCount = 0
  var attachAddPaymentMethodCloseButtonType: DismissButtonType?
  func attachAddPaymentMethod(closeButtonType: DismissButtonType) {
    attachAddPaymentMethodCallCount += 1
    attachAddPaymentMethodCloseButtonType = closeButtonType
  }
  
  var detachAddPaymentMethodCallCount = 0
  func detachAddPaymentMethod() {
    detachAddPaymentMethodCallCount += 1
  }
  
  var attachEnterAmountCallCount = 0
  func attachEnterAmount() {
    attachEnterAmountCallCount += 1
  }
  
  var detachEnterAmountCallCount = 0
  func detachEnterAmount() {
    detachEnterAmountCallCount += 1
  }
  
  var attachCardOnFileCallCount = 0
  var attachCardOnFileCallCountPaymentMethods: [PaymentMethodModel]?
  func attachCardOnFile(paymentMethods: [PaymentMethodModel]) {
    attachCardOnFileCallCount += 1
  }
  
  var detachCardOnFileCallCount = 0
  func detachCardOnFile() {
    detachCardOnFileCallCount += 1
  }
  
  var popToRootCallCount = 0
  func popToRoot() {
    popToRootCallCount += 1
  }
  
  // Variables
  var interactable: Interactable { didSet { interactableSetCallCount += 1 } }
  var interactableSetCallCount = 0
  var children: [Routing] = [Routing]() { didSet { childrenSetCallCount += 1 } }
  var childrenSetCallCount = 0
  var lifecycleSubject = PassthroughSubject<RouterLifecycle, Never>() {
    didSet {
      lifecycleSubjectSetCallCount += 1
    }
  }
  var lifecycleSubjectSetCallCount = 0
  var lifecycle: AnyPublisher<RouterLifecycle, Never> { return lifecycleSubject.eraseToAnyPublisher() }
  
  // Function Handlers
  var loadHandler: (() -> ())?
  var loadCallCount: Int = 0
  var attachChildHandler: ((_ child: Routing) -> ())?
  var attachChildCallCount: Int = 0
  var detachChildHandler: ((_ child: Routing) -> ())?
  var detachChildCallCount: Int = 0
  
  init(
    interactable: Interactable
  ) {
    self.interactable = interactable
  }
  
  var cleanupViewsCallCount = 0
  func cleanupViews() {
    cleanupViewsCallCount += 1
  }
  
  func load() {
    loadCallCount += 1
    if let loadHandler = loadHandler {
      return loadHandler()
    }
  }
  
  func attachChild(_ child: Routing) {
    attachChildCallCount += 1
    if let attachChildHandler = attachChildHandler {
      return attachChildHandler(child)
    }
  }
  
  func detachChild(_ child: Routing) {
    detachChildCallCount += 1
    if let detachChildHandler = detachChildHandler {
      return detachChildHandler(child)
    }
  }
}


final class TopupInteractableMock: TopupInteractable {
    
    
    var router: TopupRouting?
    var listener: TopupListener?
    var presentationDelegateProxy = AdaptivePresentationControllerDelegateProxy()
    
    var addPaymentMethodDidTapCloseCallCount = 0
    func addPaymentMethodDidTapClose() {
        addPaymentMethodDidTapCloseCallCount += 1
    }
    
    var addPaymentMethodDidAddCardCallCount = 0
    var addPaymentMethodDidAddCardPaymentMethod: PaymentMethodModel?
    func addPaymentMethodDidAddCard(paymentMethod: PaymentMethodModel) {
        addPaymentMethodDidAddCardCallCount += 1
        addPaymentMethodDidAddCardPaymentMethod = paymentMethod
    }
    
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
    
    var cardOnFileDidTapCloseCallCount = 0
    func cardOnFileDidTapClose() {
        cardOnFileDidTapCloseCallCount += 1
    }
    
    var cardOnFileDidTapAddCardCallCount = 0
    func cardOnFileDidTapAddCard() {
        cardOnFileDidTapAddCardCallCount += 1
    }
        
    var cardOnFileSelectedCallCount = 0
    var cardOnFileSelectedIndex: Int?
    func cardOnFileSelected(at index: Int) {
        cardOnFileSelectedCallCount += 1
        cardOnFileSelectedIndex = index
    }
    
    var addPaymentMethodTapCloseCallCount = 0
    func addPaymentMethodTapClose() {
        addPaymentMethodTapCloseCallCount += 1
    }
    
    func activate() {
        
    }
    
    func deactivate() {
        
    }
    
    var isActive: Bool { isActiveSubject.value }
    var isActiveStream: AnyPublisher<Bool, Never> { isActiveSubject.eraseToAnyPublisher() }
    private let isActiveSubject = CurrentValueSubject<Bool, Never>(false)
    
}
