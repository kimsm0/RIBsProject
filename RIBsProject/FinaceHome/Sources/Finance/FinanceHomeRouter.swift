import ModernRIBs
import AddPaymentMethod
import SuperUI
import Topup
import RIBsUtil

protocol FinanceHomeInteractable: Interactable, SuperPayDashboardListener, CardOnFileDashboardListener, AddPaymentMethodListener, TopupListener {
    
    var router: FinanceHomeRouting? { get set }
    var listener: FinanceHomeListener? { get set }
    var presentationDelegateProxy: AdaptivePresentationControllerDelegateProxy { get }    
}

protocol FinanceHomeViewControllable: ViewControllable {
    func addDashboard(_ view: ViewControllable)
}

final class FinanceHomeRouter: ViewableRouter<FinanceHomeInteractable, FinanceHomeViewControllable>, FinanceHomeRouting {
            
    private let superPayDashboardBuildable: SuperPayDashboardBuildable
    private let cardOnFileDashboardBuilable: CardOnFileDashboardBuildable
    private let addPaymentMethodBuildable: AddPaymentMethodBuildable
    private let topupBuildable: TopupBuildable
    
    private var superPayRouting: Routing?
    private var cardOnFileRouting: Routing?
    private var addPaymentMethodRouting: Routing?
    private var topupRouting: Routing?
    
    init(interactor: FinanceHomeInteractable,
         viewController: FinanceHomeViewControllable,
         superPayDashboardBuildable: SuperPayDashboardBuildable,
         cardOnFileDashboardBuilable: CardOnFileDashboardBuildable,
         addPaymentMethodBuildable: AddPaymentMethodBuildable,
         topupBuildable: TopupBuildable
    ) {
        self.superPayDashboardBuildable = superPayDashboardBuildable
        self.cardOnFileDashboardBuilable = cardOnFileDashboardBuilable
        self.addPaymentMethodBuildable = addPaymentMethodBuildable
        self.topupBuildable = topupBuildable
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
        
    }
}

extension FinanceHomeRouter {
    func attachSuperPayDashboard() {
        
        if superPayRouting == nil { //똑같은 child를 반복해서 attach하지 않도록 하기 위한 방어로직.
            let router = superPayDashboardBuildable.build(withListener: interactor)
            viewController.addDashboard(router.viewControllable)
            
            self.superPayRouting = router
            attachChild(router)
        }
    }
    
    func attachCardOnFileDashboard() {
        if cardOnFileRouting == nil { //똑같은 child를 반복해서 attach하지 않도록 하기 위한 방어로직.
            let router = cardOnFileDashboardBuilable.build(withListener: interactor)
            viewController.addDashboard(router.viewControllable)
            
            self.cardOnFileRouting = router
            attachChild(router)
        }
    }
    
    func attachAddPaymentMethod() {
        if addPaymentMethodRouting == nil {
            let router = addPaymentMethodBuildable.build(withListener: interactor, closeButtonType: .close)
            let navi = NavigationControllerable(root: router.viewControllable)
            navi.navigationController.presentationController?.delegate = interactor.presentationDelegateProxy
            viewControllable.present(navi, animated: true, completion: nil)
            addPaymentMethodRouting = router
            attachChild(router)
        }
    }
    
    func detachAddPaymentMethod() {
        if let router = addPaymentMethodRouting {
            viewController.dismiss(completion: nil)
            detachChild(router)
            addPaymentMethodRouting = nil
        }
    }
    
    func attachTopup() {
        if topupRouting == nil {
            let router = topupBuildable.build(withListener: interactor)
            topupRouting = router
            attachChild(router)
        }
    }
    
    func detachTopup() {
        if let router = topupRouting {
            detachChild(router)
            topupRouting = nil
        }
    }
}
