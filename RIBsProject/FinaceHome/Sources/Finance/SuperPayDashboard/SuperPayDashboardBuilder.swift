//
//  SuperPayDashboardBuilder.swift
//  MiniSuperApp
//
//  Created by kimsoomin_mac2022 on 4/12/24.
//

import ModernRIBs
import CombineUtil

//부모리블렛으로 부터 받고 싶은 dependency는 여기에 선언해준다.
public protocol SuperPayDashboardDependency: Dependency {
    var balance: ReadOnlyCurrentValuePublisher<Double> { get }
}

//component => 현재 리블렛과 자식 리블렛이 필요한 객체를 담고 있는 바구니 역할.
final class SuperPayDashboardComponent: Component<SuperPayDashboardDependency>, SuperPayDashboardInteractorDependency {
    
    var balance: ReadOnlyCurrentValuePublisher<Double>{
        dependency.balance
    }
}

// MARK: - Builder

public protocol SuperPayDashboardBuildable: Buildable {
    func build(withListener listener: SuperPayDashboardListener) -> ViewableRouting
}

public final class SuperPayDashboardBuilder: Builder<SuperPayDashboardDependency>, SuperPayDashboardBuildable {

    public override init(dependency: SuperPayDashboardDependency) {
        super.init(dependency: dependency)
    }

    public func build(withListener listener: SuperPayDashboardListener) -> ViewableRouting {
        let component = SuperPayDashboardComponent(dependency: dependency)
        let viewController = SuperPayDashboardViewController()
        let interactor = SuperPayDashboardInteractor(
            presenter: viewController,
            dependency: component
        )
        interactor.listener = listener
        return SuperPayDashboardRouter(interactor: interactor, viewController: viewController)
    }
}
