//
//  EnterAmountInteractorTests.swift
//  RIBsProject
//
//  Created by kimsoomin_mac2022 on 4/16/24.
//

@testable import TopupImp
import XCTest
import FinanceEntity
import FinanceRepositoryTestSupport


final class EnterAmountInteractorTests: XCTestCase {

    //system under test : 검증 대상이 되는 객체의 변수명
    private var sut: EnterAmountInteractor!
    private var presenter: EnterAmountPresentableMock!
    private var depengency: EnterAmountDepengencyMock!
    private var listener: EnterAmountListenerMock!
    
    private var repository: SuperPayRepositoryMock! {
        depengency.superPayRepository as? SuperPayRepositoryMock
    }
    
    override func setUp() {
        super.setUp()
        self.presenter = EnterAmountPresentableMock()
        self.depengency = EnterAmountDepengencyMock()
        self.listener = EnterAmountListenerMock()
        
        sut = EnterAmountInteractor(
            presenter: presenter,
            dependency: depengency
        )    
        sut.listener = self.listener
    }

    // MARK: - Tests

    func test_activate() {
    
        //given
        let paymentMethod = PaymentMethodModel(id: "test_id",
                                               name: "test_name",
                                               digits: "test_1234",
                                               color: "#13ABE8FF",
                                               isPrimary: false
        )
        depengency.selectedpaymentMethodSubject.send(paymentMethod)
        //when
        sut.activate()
        
        //then
        XCTAssertEqual(presenter.updateSelectedPaymentMethodCallCount, 1)
        XCTAssertEqual(presenter.updateSelectedPaymentMethodViewModel?.name, "test_name test_1234")
        XCTAssertNotNil(presenter.updateSelectedPaymentMethodViewModel?.image)
    }
    
    func test_topup_with_validAmount(){
        //given
        let paymentMethod = PaymentMethodModel(id: "test_id",
                                               name: "test_name",
                                               digits: "test_1234",
                                               color: "#13ABE8FF",
                                               isPrimary: false
        )
        depengency.selectedpaymentMethodSubject.send(paymentMethod)
        //when
        sut.didTapTopup(with: 1_000_000)
        
        //then
        //_ = XCTWaiter.wait(for: [expectation(description: "")], timeout: 0.1)
        XCTAssertEqual(presenter.startLoadingCallCount, 1)
        XCTAssertEqual(presenter.stopLoadingCallCount, 1)
        XCTAssertEqual(repository.topupCallCount, 1)
        XCTAssertEqual(repository.paymentMethodID, "test_id")
        XCTAssertEqual(repository.topupAmount, 1_000_000)
        XCTAssertEqual(listener.enterAmountDidFinishTopupCallCount, 1)
        
    }
    
    func test_topup_with_validAmount_failure (){
        //given
        let paymentMethod = PaymentMethodModel(id: "test_id",
                                               name: "test_name",
                                               digits: "test_1234",
                                               color: "#13ABE8FF",
                                               isPrimary: false
        )
        depengency.selectedpaymentMethodSubject.send(paymentMethod)
        repository.shouldTopupSucceeed = false
        //when
        sut.didTapTopup(with: 1_000_000)
        
        //then
        //_ = XCTWaiter.wait(for: [expectation(description: "")], timeout: 0.1)
        XCTAssertEqual(presenter.startLoadingCallCount, 1)
        XCTAssertEqual(presenter.stopLoadingCallCount, 1)
        XCTAssertEqual(repository.topupCallCount, 1)
        XCTAssertEqual(repository.paymentMethodID, "test_id")
        XCTAssertEqual(repository.topupAmount, 1_000_000)
        XCTAssertEqual(listener.enterAmountDidFinishTopupCallCount, 0)
        
    }
    
    func testDidTapClose(){
        sut.didTapClose()
        XCTAssertEqual(listener.enterAmountDidTapCloseCallCount, 1)
    }
    
    func testDidTapPaymentMethod(){
        sut.didTapPaymentMethod()
        XCTAssertEqual(listener.enterAmountDidTapPaymentMethodCallCount, 1)
    }
}
