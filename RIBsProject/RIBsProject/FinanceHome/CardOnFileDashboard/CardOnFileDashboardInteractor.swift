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

//부모 리블렛의 인터렉터 프로토콜
protocol CardOnFileDashboardListener: AnyObject {
    func cardOnFileDashboardDidTabAddPaymentMethod()
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
extension CardOnFileDashboardInteractor {
    func didTabAddPaymentMethod() {
        /*
         현재 리블렛은 FinanceHome 리블렛의 일부 영역 뷰를 담당하는 리블렛.
         현재 리블렛에서 modal로 하위 리블렛의 화면을 띄워도 상관 없지만, 프로젝트 전체 구조로 봤을 때,
         전체 리블렛인 (부분 리블렛이 아닌)FinanceHome에서 연결하는것이 자연스러움.
         */
        listener?.cardOnFileDashboardDidTabAddPaymentMethod()
    }
}
