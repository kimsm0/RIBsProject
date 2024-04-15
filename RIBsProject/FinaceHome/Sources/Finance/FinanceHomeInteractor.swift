import ModernRIBs
import SuperUI
import FinanceEntity

protocol FinanceHomeRouting: ViewableRouting {
    func attachSuperPayDashboard()
    func attachCardOnFileDashboard()
    func attachAddPaymentMethod()
    func detachAddPaymentMethod()
    func attachTopup()
    func detachTopup()
}

protocol FinanceHomePresentable: Presentable {
  var listener: FinanceHomePresentableListener? { get set }
}

public protocol FinanceHomeListener: AnyObject {
  
}

final class FinanceHomeInteractor: PresentableInteractor<FinanceHomePresentable>, FinanceHomeInteractable, FinanceHomePresentableListener, AdaptivePresentationControllerDelegate {
    
            
    weak var router: FinanceHomeRouting?
    weak var listener: FinanceHomeListener?
        
    let presentationDelegateProxy: AdaptivePresentationControllerDelegateProxy
    
    override init(presenter: FinanceHomePresentable) {
        self.presentationDelegateProxy = AdaptivePresentationControllerDelegateProxy()
        super.init(presenter: presenter)
        presenter.listener = self
        self.presentationDelegateProxy.delegate = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        router?.attachSuperPayDashboard()
        router?.attachCardOnFileDashboard()
    }
    
    override func willResignActive() {
        super.willResignActive()
    }
}

extension FinanceHomeInteractor {
    
    // MARK: CardOnFileDashboadListener
    func cardOnFileDashboardDidTabAddPaymentMethod() {
        router?.attachAddPaymentMethod()
    }
    
    // MARK: AddPaymentMethodListener
    func addPaymentMethodTapClose() {
        router?.detachAddPaymentMethod()
    }
    
    func addPaymentMethodDidAddCard(paymentMethod: PaymentMethodModel) {
        router?.detachAddPaymentMethod()
    }
    
    func superPayDashboardDidTap() {
        router?.attachTopup()
    }
    
    func topupDidClose() {
        router?.detachTopup()
    }
    
    func topupFinish() {
        router?.detachTopup()
    }
    
}

extension FinanceHomeInteractor {
    func presentationControllerDidDismiss() {
        router?.detachAddPaymentMethod()
    }
}
