//
//  TopupInteractorTests.swift
//  RIBsProject
//
//  Created by kimsoomin_mac2022 on 4/16/24.
//

@testable import TopupImp
import XCTest
import TopupTestSupport
import FinanceEntity
import FinanceRepositoryTestSupport

final class TopupInteractorTests: XCTestCase {
    
    private var sut: TopupInteractor!
    private var dependency: TopupDepengencyMock!
    private var listener: TopupListenerMock!
    private var router: TopupRoutingMock!
    
    
    private var cardOnfFileRespositody: CardOnFileRepositoryMock {
        dependency.cardOnFileRepository as! CardOnFileRepositoryMock
    }
    override func setUp() {
        super.setUp()

        self.dependency = TopupDepengencyMock()
        self.listener = TopupListenerMock()
        
        let interator = TopupInteractor(depengency: self.dependency)
        self.router = TopupRoutingMock(interactable: interator)
        
        interator.listener = self.listener
        interator.router = self.router
        sut = interator
    }

    // MARK: - Tests

    func test_activate() {
        let cards = [
            PaymentMethodModel.init(id: "0", name: "test", digits: "1234", color: "", isPrimary: false)
        ]
        cardOnfFileRespositody.cardOnFileSubject.send(cards)
        sut.activate()
        
        XCTAssertEqual(router.attachEnterAmountCallCount, 1)
        XCTAssertEqual(dependency.paymentMethodStream.value.name, "test")
    }
    
    func test_activate_empty() {
        cardOnfFileRespositody.cardOnFileSubject.send([])
        sut.activate()
        
        XCTAssertEqual(router.attachAddPaymentMethodCallCount, 1)
        XCTAssertEqual(router.attachAddPaymentMethodCloseButtonType, .close)
    }
    
    func test_addCard_withCards() {
        let cards = [
            PaymentMethodModel.init(id: "0", name: "test", digits: "1234", color: "", isPrimary: false)
        ]
        cardOnfFileRespositody.cardOnFileSubject.send(cards)
        
        let newCard = PaymentMethodModel.init(id: "new", name: "new_test", digits: "12345678", color: "", isPrimary: false)
        
        sut.activate()
        sut.addPaymentMethodDidAddCard(paymentMethod: newCard)
        
        XCTAssertEqual(router.popToRootCallCount, 1)
        XCTAssertEqual(dependency.paymentMethodStream.value.name, "new_test")
    }
    
    func test_addCard_withEmptyCard() {
        cardOnfFileRespositody.cardOnFileSubject.send([])
        
        let newCard = PaymentMethodModel.init(id: "new", name: "new_test", digits: "12345678", color: "", isPrimary: false)
        
        sut.activate()
        sut.addPaymentMethodDidAddCard(paymentMethod: newCard)
        
        XCTAssertEqual(router.attachEnterAmountCallCount, 1)
        XCTAssertEqual(dependency.paymentMethodStream.value.name, "new_test")
    }
    
    func test_addCard_didTapClose() {
        let cards = [
            PaymentMethodModel.init(id: "0", name: "test", digits: "1234", color: "", isPrimary: false)
        ]
        cardOnfFileRespositody.cardOnFileSubject.send(cards)
                
        
        sut.activate()
        sut.addPaymentMethodTapClose()
        
        XCTAssertEqual(router.detachAddPaymentMethodCallCount, 1)
    }
    
    func test_addCard_didTapClose_withEmptyCard() {
        cardOnfFileRespositody.cardOnFileSubject.send([])
                
        
        sut.activate()
        sut.addPaymentMethodTapClose()
        
        //XCTAssertEqual(router.detachAddPaymentMethodCallCount, 1)
        XCTAssertEqual(listener.topupDidCloseCallCount, 1)
    }
    
}
