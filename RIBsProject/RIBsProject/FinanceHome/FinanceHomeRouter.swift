import ModernRIBs

protocol FinanceHomeInteractable: Interactable, SuperPayDashboardListener, CardOnFileDashboardListener {
  var router: FinanceHomeRouting? { get set }
  var listener: FinanceHomeListener? { get set }
}

protocol FinanceHomeViewControllable: ViewControllable {
    func addDashboard(_ view: ViewControllable)
}

final class FinanceHomeRouter: ViewableRouter<FinanceHomeInteractable, FinanceHomeViewControllable>, FinanceHomeRouting {
    
    private let superPayDashboardBuildable: SuperPayDashboardBuildable
    private let cardOnFileDashboardBuilable: CardOnFileDashboardBuildable
    
    private var superPayRouting: Routing?
    private var cardOnFileRouting: Routing?
    
    init(interactor: FinanceHomeInteractable,
         viewController: FinanceHomeViewControllable,
         superPayDashboardBuildable: SuperPayDashboardBuildable,
         cardOnFileDashboardBuilable: CardOnFileDashboardBuildable
    ) {
        self.superPayDashboardBuildable = superPayDashboardBuildable
        self.cardOnFileDashboardBuilable = cardOnFileDashboardBuilable
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
}
