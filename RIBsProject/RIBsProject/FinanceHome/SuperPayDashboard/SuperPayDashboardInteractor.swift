//
//  SuperPayDashboardInteractor.swift
//  MiniSuperApp
//
//  Created by kimsoomin_mac2022 on 4/12/24.
//

import ModernRIBs
import Combine

protocol SuperPayDashboardRouting: ViewableRouting {
    
}

protocol SuperPayDashboardPresentable: Presentable {
    var listener: SuperPayDashboardPresentableListener? { get set }
    func updateBalance(_ balance: String)
}

protocol SuperPayDashboardListener: AnyObject {
    
}

//생성인자로 받아야할 것들을 이렇게 프로토콜로 따로 빼서 관리해주면, 나중에 수정할 부분이 줄어들 수 있다. 
protocol SuperPayDashboardInteractorDependency {
    var balance: ReadOnlyCurrentValuePublisher<Double> { get }    
}

final class SuperPayDashboardInteractor: PresentableInteractor<SuperPayDashboardPresentable>, SuperPayDashboardInteractable, SuperPayDashboardPresentableListener {

    weak var router: SuperPayDashboardRouting?
    weak var listener: SuperPayDashboardListener?
    
    private let dependency: SuperPayDashboardInteractorDependency
    private var subscriptions: Set<AnyCancellable>
    init(
        presenter: SuperPayDashboardPresentable,
        dependency: SuperPayDashboardInteractorDependency
    ) {
        self.dependency = dependency
        self.subscriptions = .init()
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        //인터렉터에서 값을 업데이트 할 때는 프레젠터를 호출.
        dependency.balance.sink {[weak self] balance in
            self?.presenter.updateBalance(balance.decimalFormat)
        }.store(in: &subscriptions)
    }

    override func willResignActive() {
        super.willResignActive()
        
    }
}
