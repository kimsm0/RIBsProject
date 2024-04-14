//
//  CardOnFileInteractor.swift
//  RIBsProject
//
//  Created by kimsoomin_mac2022 on 4/13/24.
//

import ModernRIBs

protocol CardOnFileRouting: ViewableRouting {
    
}

protocol CardOnFilePresentable: Presentable {
    var listener: CardOnFilePresentableListener? { get set }
    func update(with paymentMethods: [PaymentMethodViewModel])
    
}

protocol CardOnFileListener: AnyObject {
    func cardOnFileDidTapClose()
    func cardOnFileDidTapAddCard()
    func cardOnFileSelected(at: Int)
}

final class CardOnFileInteractor: PresentableInteractor<CardOnFilePresentable>, CardOnFileInteractable, CardOnFilePresentableListener {

    weak var router: CardOnFileRouting?
    weak var listener: CardOnFileListener?
    
    private let paymentMethods: [PaymentMethodModel]
    
    init(
        presenter: CardOnFilePresentable,
        paymentMethods: [PaymentMethodModel]
    ) {
        self.paymentMethods = paymentMethods
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        presenter.update(with: paymentMethods.map(PaymentMethodViewModel.init))
    }

    override func willResignActive() {
        super.willResignActive()
    }
}

// MARK:CardOnFile ViewController

extension CardOnFileInteractor {
    func didTapClose() {
        listener?.cardOnFileDidTapClose()
    }
    
    func didSelectItem(at index: Int) {
        if index >= paymentMethods.count {
            listener?.cardOnFileDidTapAddCard()
        }else {
            listener?.cardOnFileSelected(at: index)
        }
    }
}
