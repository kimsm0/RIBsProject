//
//  TopupInteractor.swift
//  RIBsProject
//
//  Created by kimsoomin_mac2022 on 4/13/24.
//

/*
 슈퍼페이의 홈화면(FinanceHome) 에서는 각 뷰 영역별로 SuperPayDashboard, CardOnFileDashboard 리블렛으로 구성되어 있다.
 SuperPay영역에서 충전하기 버튼을 누르면
 1. 현재 등록된 카드가 없음 -> 카드 추가 화면으로 이동
 2. 현재 등록된 카드가 있음 -> 잔액 충전 화면으로 이동
 분기처리가 되어야 한다.
 
 해당 로직을 FinanceHome에서 진행하기에는 하위 리블렛에서 해야할 작업이 많아질 것으로 보이고, 재사용성이 떨어질 것으로 판단되어
 view less 리블렛 Topup리블렛을 하나 생성하여
 분기처리에 대한 로직을 여기서 따로 나누어 진행하도록 한다.
 
 */
import ModernRIBs
import RIBsUtil
import FinanceEntity
import FinanceRepository
import CombineUtil
import SuperUI
import Utils
import Topup

protocol TopupRouting: Routing {
    func cleanupViews()
    func attachAddPaymentMethod(closeButtonType: DismissButtonType)
    func detachAddPaymentMethod()
    func attachEnterAmount()
    func detachEnterAmount()
    func attachCardOnFile(paymentMethods: [PaymentMethodModel])
    func detachCardOnFile()
    func popToRoot()
}



protocol TopupInteractorDependency{
    var cardOnFileRepository: CardOnFileReposistory { get }
    var paymentMethodStream: CurrentValuePublisher<PaymentMethodModel> { get }
}

final class TopupInteractor: Interactor, TopupInteractable, AdaptivePresentationControllerDelegate {
    
    weak var router: TopupRouting?
    weak var listener: TopupListener?

    private var depengency: TopupInteractorDependency
        
    private var isEnterAmountRoot = false
    
    let presentationDelegateProxy: AdaptivePresentationControllerDelegateProxy
    
    private var paymetnMethods: [PaymentMethodModel] {
        depengency.cardOnFileRepository.cardOnfFile.value
    }
    
    init(
        depengency: TopupInteractorDependency
    ) {
        self.presentationDelegateProxy = AdaptivePresentationControllerDelegateProxy()
        self.depengency = depengency
        super.init()
        self.presentationDelegateProxy.delegate = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        if let card = depengency.cardOnFileRepository.cardOnfFile.value.first {
            //충전
            depengency.paymentMethodStream.send(card)
            router?.attachEnterAmount()
            isEnterAmountRoot = true
        }else {
            // 카드 추가

            router?.attachAddPaymentMethod(closeButtonType: .close)
            isEnterAmountRoot = false
        }
    }

    override func willResignActive() {
        super.willResignActive()
        router?.cleanupViews()
    }
}

/*
 view less 리블렛은 본인이 띄운 뷰를 해당 리블렛에서 닫아야 하는 책임을 갖는다.
 (view를 갖고 있는 리블렛은 닫는 책임이 부모한테 있음) 
 */
extension TopupInteractor {
    func presentationControllerDidDismiss() {
        listener?.topupDidClose()
    }
    func addPaymentMethodTapClose() {
        router?.detachAddPaymentMethod()
        if !isEnterAmountRoot {
            router?.detachAddPaymentMethod()
            listener?.topupDidClose()
        }
    }
    
    func addPaymentMethodDidAddCard(paymentMethod: PaymentMethodModel) {
        depengency.paymentMethodStream.send(paymentMethod)
        if isEnterAmountRoot {
            router?.popToRoot()
        }else {
            isEnterAmountRoot = true
            router?.attachEnterAmount()
        }
    }
}

// MARK: EnterAmount
extension TopupInteractor {

    func enterAmountDidTapClose() {
        router?.detachEnterAmount()
        listener?.topupDidClose()
    }
    
    func enterAmountDidTapPaymentMethod() {
        router?.attachCardOnFile(paymentMethods: paymetnMethods)
    }
    
    func cardOnFileDidTapClose() {
        router?.detachCardOnFile()
    }
    
    // TODO: check ( router 코드는 추가한거 )
    func enterAmountDidFinishTopup() {
        router?.detachEnterAmount()
        listener?.topupFinish()
    }
}

// MARK: CardOnFile
extension TopupInteractor {
    func cardOnFileSelected(at index: Int) {
        if let selected = paymetnMethods[safe: index] {
            depengency.paymentMethodStream.send(selected)
        }
        router?.detachCardOnFile()
    }
    //카드 추가
    func cardOnFileDidTapAddCard() {
        router?.attachAddPaymentMethod(closeButtonType: .back)        
    }
}
