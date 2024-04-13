//
//  CardOnFileDashboardInteractor.swift
//  RIBsProject
//
//  Created by kimsoomin_mac2022 on 4/13/24.
//

import ModernRIBs
import Combine

protocol CardOnFileDashboardRouting: ViewableRouting {
    
}

protocol CardOnFileDashboardPresentable: Presentable {
    var listener: CardOnFileDashboardPresentableListener? { get set }
    func update(with viewModels: [PaymentMethodViewModel])
}

protocol CardOnFileDashboardListener: AnyObject {
    
}

protocol CardOnFileDashboardInteractorDependency {
    var cardOnFileRepository: CardOnFileReposistory { get }
}

final class CardOnFileDashboardInteractor: PresentableInteractor<CardOnFileDashboardPresentable>, CardOnFileDashboardInteractable, CardOnFileDashboardPresentableListener {

    weak var router: CardOnFileDashboardRouting?
    weak var listener: CardOnFileDashboardListener?

    private let depengency: CardOnFileDashboardInteractorDependency?
    
    private var subscriptions: Set<AnyCancellable>
    init(
        presenter: CardOnFileDashboardPresentable,
        depengency: CardOnFileDashboardInteractorDependency
    ) {
        self.depengency = depengency
        self.subscriptions = .init()
        
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        depengency?.cardOnFileRepository.cardOnfFile
            .sink(receiveValue: {list in
                let viewModels = list.prefix(3).map(PaymentMethodViewModel.init)
                self.presenter.update(with: viewModels)
            }).store(in: &subscriptions)
    }

    override func willResignActive() {
        super.willResignActive()
        //retain cycle 삭제됨. weak self 안해줘도 되는 방법. 
        subscriptions.forEach{ $0.cancel() }
        subscriptions.removeAll()
    }
}
