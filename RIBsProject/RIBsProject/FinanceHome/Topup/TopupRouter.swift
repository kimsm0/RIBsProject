//
//  TopupRouter.swift
//  RIBsProject
//
//  Created by kimsoomin_mac2022 on 4/13/24.
//

import ModernRIBs

protocol TopupInteractable: Interactable, AddPaymentMethodListener, EnterAmountListener, CardOnFileListener{
    var router: TopupRouting? { get set }
    var listener: TopupListener? { get set }
    var presentationDelegateProxy: AdaptivePresentationControllerDelegateProxy { get }
}

protocol TopupViewControllable: ViewControllable {

}

final class TopupRouter: Router<TopupInteractable>, TopupRouting {

    private var navigationControllerable: NavigationControllerable?
    
    private let addPaymentMethodBuildable: AddPaymentMethodBuildable
    private var addPaymenttMethodRouting: Routing?
    
    private let enterAmountBuildable: EnterAmountBuildable
    private var enterAmountRouting: Routing?
    
    private let cardOnFileBuildable: CardOnFileBuildable
    private var cardOnFileRouting: Routing?
    
     
    
    init(interactor: TopupInteractable, 
         viewController: ViewControllable,
         addPaymentMethodBuildable: AddPaymentMethodBuildable,
         enterAmountBuildable: EnterAmountBuildable,
         cardOnFileBuildable: CardOnFileBuildable
    ) {
        self.viewController = viewController
        self.addPaymentMethodBuildable = addPaymentMethodBuildable
        self.enterAmountBuildable = enterAmountBuildable
        self.cardOnFileBuildable = cardOnFileBuildable
        super.init(interactor: interactor)
        interactor.router = self
    }

    func cleanupViews() {
    }

    // MARK: - Private

    private let viewController: ViewControllable
}

extension TopupRouter {
    func attachAddPaymentMethod(closeButtonType: DismissButtonType) {
        if addPaymenttMethodRouting == nil {
            let router = addPaymentMethodBuildable.build(withListener: interactor, closeButtonType: closeButtonType)
            
            if let navi = navigationControllerable {
                navi.pushViewController(router.viewControllable, animated: true)
                
            }else {
                presentInsideNavigation(router.viewControllable)
            }
            attachChild(router)
            addPaymenttMethodRouting = router
        }
    }
    
    func detachAddPaymentMethod() {
        guard let router = addPaymenttMethodRouting else { return }
        if let navi = navigationControllerable {
            navi.dismiss(completion: nil)
        }else {
            dismissPresentedNavigation(completion: nil)
        }
        //navigationControllerable?.popViewController(animated: true)
        detachChild(router)
        addPaymenttMethodRouting = nil
    }
}
extension TopupRouter {
    func attachEnterAmount() {
        if enterAmountRouting == nil {
            let router = enterAmountBuildable.build(withListener: interactor)
            
            if let navi = navigationControllerable {
                navi.setViewControllers([router.viewControllable])
                resetChildRouting()
            }else {
                presentInsideNavigation(router.viewControllable)
            }
            
            attachChild(router)
            enterAmountRouting = router
        }
    }
    
    func detachEnterAmount() {
        guard let router  = enterAmountRouting else { return }
        if let navi = navigationControllerable {
            navi.dismiss(completion: nil)
        }else {
            dismissPresentedNavigation(completion: nil)
        }
        detachChild(router)
        enterAmountRouting = nil        
    }
}

extension TopupRouter {
    func attachCardOnFile(paymentMethods: [PaymentMethodModel]) {
        if cardOnFileRouting == nil {
            let router = cardOnFileBuildable.build(withListener: interactor, paymentMethods: paymentMethods)
            navigationControllerable?.pushViewController(router.viewControllable, animated: true)
            attachChild(router)
            cardOnFileRouting = router
        }
    }
      
    func detachCardOnFile() {
        guard let router  = cardOnFileRouting else { return }
        navigationControllerable?.popViewController(animated: true)
        detachChild(router)
        cardOnFileRouting = nil
    }
}

extension TopupRouter {
    private func presentInsideNavigation(_ viewControllerable: ViewControllable) {
        let navigation = NavigationControllerable(root: viewControllerable)
        navigation.navigationController.presentationController?.delegate = interactor.presentationDelegateProxy
        self.navigationControllerable = navigation
        viewController.present(navigation, animated: true, completion: nil)
    }
    
    private func dismissPresentedNavigation(completion: (()-> Void)?) {
        if self.navigationControllerable == nil {
            return
        }
        
        viewController.dismiss(completion: nil)
        self.navigationControllerable = nil
    }
    
    /*
     스택에 쌓인 뷰컨을 모두 삭제할 때,
     자식 라우터들도 모두 같이 리셋 진행.
     */
    private func resetChildRouting(){
     
        if let router = cardOnFileRouting  {
            detachChild(router)
            cardOnFileRouting = nil
        }
        if let router = addPaymenttMethodRouting {
            detachChild(router)
            addPaymenttMethodRouting = nil
        }
    }
    
    func popToRoot() {
        navigationControllerable?.popToRoot(animated: true)
        resetChildRouting()
    }
}


