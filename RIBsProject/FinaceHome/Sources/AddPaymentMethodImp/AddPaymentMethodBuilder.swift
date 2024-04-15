//
//  AddPaymentMethodBuilder.swift
//  RIBsProject
//
//  Created by kimsoomin_mac2022 on 4/13/24.
//
import ModernRIBs
import FinanceRepository
import RIBsUtil
import AddPaymentMethod

public protocol AddPaymentMethodDependency: Dependency {
    var cardOnFileRepository:  CardOnFileReposistory { get }
}

final class AddPaymentMethodComponent: Component<AddPaymentMethodDependency>, AddPaymentMethodInteractorDependency {
    var cardOnFileRepository:  CardOnFileReposistory{
        dependency.cardOnFileRepository
    }

}

// MARK: - Builder
public final class AddPaymentMethodBuilder: Builder<AddPaymentMethodDependency>, AddPaymentMethodBuildable {

    public override init(dependency: AddPaymentMethodDependency) {        
        super.init(dependency: dependency)
    }

    public func build(withListener listener: AddPaymentMethodListener, closeButtonType: DismissButtonType) -> ViewableRouting {
        let component = AddPaymentMethodComponent(dependency: dependency)
        let viewController = AddPaymentMethodViewController(closeButtonType: closeButtonType)
        
        let interactor = AddPaymentMethodInteractor(
            presenter: viewController, 
            depengency: component
        )
        interactor.listener = listener
        return AddPaymentMethodRouter(interactor: interactor, viewController: viewController)
    }
}
