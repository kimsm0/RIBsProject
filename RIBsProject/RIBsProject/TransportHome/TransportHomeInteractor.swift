import ModernRIBs
import Combine
import Foundation

protocol TransportHomeRouting: ViewableRouting {
}

protocol TransportHomePresentable: Presentable {
    var listener: TransportHomePresentableListener? { get set }
    func setSuperPayBalance(_ balanceText: String)
}

protocol TransportHomeListener: AnyObject {
  func transportHomeDidTapClose()
}

protocol TransportHomeInteractorDependency {
    var superPayRepository: SuperPayRepository { get }
}

final class TransportHomeInteractor: PresentableInteractor<TransportHomePresentable>, TransportHomeInteractable, TransportHomePresentableListener {
    
    weak var router: TransportHomeRouting?
    weak var listener: TransportHomeListener?
    
    private var depengency: TransportHomeInteractorDependency
    
    private var subscriptions: Set<AnyCancellable>
    init(
        presenter: TransportHomePresentable,
        depengency: TransportHomeInteractorDependency
    ) {
        self.subscriptions = .init()
        self.depengency = depengency
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        depengency.superPayRepository.balance
            .sink {[weak self] balance in
                self?.presenter.setSuperPayBalance(balance.decimalFormat)
            }.store(in: &subscriptions)    
    }
    
    override func willResignActive() {
        super.willResignActive()
            
    }
    
    func didTapBack() {
        listener?.transportHomeDidTapClose()
    }
}
