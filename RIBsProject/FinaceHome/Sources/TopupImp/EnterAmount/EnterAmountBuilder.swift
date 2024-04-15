//
//  EnterAmountBuilder.swift
//  RIBsProject
//
//  Created by kimsoomin_mac2022 on 4/13/24.
//

import ModernRIBs
import CombineUtil
import FinanceEntity
import FinanceRepository

protocol EnterAmountDependency: Dependency {
    var selectedPaymentMethod: ReadOnlyCurrentValuePublisher<PaymentMethodModel> { get }
    var superPayRepository: SuperPayRepository { get }
}

final class EnterAmountComponent: Component<EnterAmountDependency>, EnterAmountInteractorDependency {
    var selectedpaymentMethod: ReadOnlyCurrentValuePublisher<PaymentMethodModel> {
        dependency.selectedPaymentMethod
    }
    var superPayRepository: SuperPayRepository {
        dependency.superPayRepository
    }
}

// MARK: - Builder

protocol EnterAmountBuildable: Buildable {
    func build(withListener listener: EnterAmountListener) -> EnterAmountRouting
}

final class EnterAmountBuilder: Builder<EnterAmountDependency>, EnterAmountBuildable {

    override init(dependency: EnterAmountDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: EnterAmountListener) -> EnterAmountRouting {
        let component = EnterAmountComponent(dependency: dependency)
        let viewController = EnterAmountViewController()
        let interactor = EnterAmountInteractor(presenter: viewController, dependency: component)
        interactor.listener = listener
        return EnterAmountRouter(interactor: interactor, viewController: viewController)
    }
}
