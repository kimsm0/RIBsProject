//
//  TopupBuilder.swift
//  RIBsProject
//
//  Created by kimsoomin_mac2022 on 4/13/24.
//

import ModernRIBs
import FinanceRepository
import FinanceEntity
import AddPaymentMethodImp
import AddPaymentMethod
import CombineUtil
import Topup
/*
 현재 리블렛이 필요한 것들을 정의함
 해당 리블렛은 viewless 리블렛이므로, 부모 리블렛이 뷰컨을 하나 지정해주어야 한다.
 */
public protocol TopupDependency: Dependency {
    var topupBaseViewController: ViewControllable { get }
    var cardOnFileRepository: CardOnFileReposistory { get }
    var superPayRepository: SuperPayRepository { get }
    var addPaymentMethodBuilder: AddPaymentMethodBuildable { get }
}

final class TopupComponent: Component<TopupDependency>, TopupInteractorDependency, AddPaymentMethodDependency, EnterAmountDependency, CardOnFileDependency {
    var superPayRepository: SuperPayRepository { dependency.superPayRepository }
        
    var selectedPaymentMethod: ReadOnlyCurrentValuePublisher<PaymentMethodModel> {
        paymentMethodStream
    }    
    
    var cardOnFileRepository: CardOnFileReposistory {
        dependency.cardOnFileRepository
    }
    
    var addPaymentMethodBuilder: AddPaymentMethodBuildable {
        dependency.addPaymentMethodBuilder
    }
    
    fileprivate var topupBaseViewController: ViewControllable {
        return dependency.topupBaseViewController
    }
    
    let paymentMethodStream: CurrentValuePublisher<PaymentMethodModel>
    
    init(dependency: TopupDependency,
         paymentMethodStream: CurrentValuePublisher<PaymentMethodModel>
    ){
        self.paymentMethodStream = paymentMethodStream
        super.init(dependency: dependency)
    }
}

// MARK: - Builder



public final class TopupBuilder: Builder<TopupDependency>, TopupBuildable {

    public override init(dependency: TopupDependency) {
        super.init(dependency: dependency)
    }

    public func build(withListener listener: TopupListener) -> Routing {
        let paymetnMethodStream = CurrentValuePublisher(PaymentMethodModel(id: "", name: "", digits: "", color: "", isPrimary: false))
                        
        let component = TopupComponent(dependency: dependency, paymentMethodStream: paymetnMethodStream)
        let interactor = TopupInteractor(depengency: component)
        interactor.listener = listener
        
        //let addPaymentMethodBuilder = AddPaymentMethodBuilder(dependency: component)
        let enterAmountBuilder = EnterAmountBuilder(dependency: component)
        let cardOnFileBuilder = CardOnFileBuilder(dependency: component)
        
        return TopupRouter(
            interactor: interactor,
            viewController: component.topupBaseViewController,
            addPaymentMethodBuildable: component.addPaymentMethodBuilder,
            enterAmountBuildable: enterAmountBuilder,
            cardOnFileBuildable: cardOnFileBuilder
        )
    }
}
