//
//  AddPaymentMethodInteractor.swift
//  RIBsProject
//
//  Created by kimsoomin_mac2022 on 4/13/24.
//

import ModernRIBs
import Combine
import FinanceEntity
import FinanceRepository
import AddPaymentMethod
import Foundation

protocol AddPaymentMethodRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol AddPaymentMethodPresentable: Presentable {
    var listener: AddPaymentMethodPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}



protocol AddPaymentMethodInteractorDependency {
    var cardOnFileRepository: CardOnFileReposistory { get }
}

final class AddPaymentMethodInteractor: PresentableInteractor<AddPaymentMethodPresentable>, AddPaymentMethodInteractable, AddPaymentMethodPresentableListener {

    weak var router: AddPaymentMethodRouting?
    weak var listener: AddPaymentMethodListener?

    private let depengency: AddPaymentMethodInteractorDependency
    
    private var subscription: Set<AnyCancellable>
    init(
        presenter: AddPaymentMethodPresentable,
        depengency: AddPaymentMethodInteractorDependency
    ) {
        self.subscription = .init()
        self.depengency = depengency
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}

extension AddPaymentMethodInteractor {
    func didTabClose() {
        listener?.addPaymentMethodTapClose()
    }
    
    func didTabConfirm(num: String, cvs: String, expire: String) {
        let info = AddPaymentMethodInfo(numnber: num, cvs: cvs, expiration: expire)
        depengency.cardOnFileRepository.addCard(info: info)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                
            } receiveValue: {[weak self] resultModel in
                self?.listener?.addPaymentMethodDidAddCard(paymentMethod: resultModel)
            }.store(in: &subscription)
    }
}
