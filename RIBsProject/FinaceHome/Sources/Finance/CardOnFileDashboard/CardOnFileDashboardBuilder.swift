//
//  CardOnFileDashboardBuilder.swift
//  RIBsProject
//
//  Created by kimsoomin_mac2022 on 4/13/24.
//

import ModernRIBs
import FinanceRepository

public  protocol CardOnFileDashboardDependency: Dependency {
    var cardOnFileRepository: CardOnFileReposistory { get }
}

final class CardOnFileDashboardComponent: Component<CardOnFileDashboardDependency>, CardOnFileDashboardInteractorDependency {

    var cardOnFileRepository: CardOnFileReposistory {
        dependency.cardOnFileRepository
    }
}

// MARK: - Builder

public  protocol CardOnFileDashboardBuildable: Buildable {
    func build(withListener listener: CardOnFileDashboardListener) -> ViewableRouting
}

public  final class CardOnFileDashboardBuilder: Builder<CardOnFileDashboardDependency>, CardOnFileDashboardBuildable {

    public override init(dependency: CardOnFileDashboardDependency) {
        super.init(dependency: dependency)
    }

    public func build(withListener listener: CardOnFileDashboardListener) -> ViewableRouting {
        let component = CardOnFileDashboardComponent(dependency: dependency)
        let viewController = CardOnFileDashboardViewController()
        let interactor = CardOnFileDashboardInteractor(
            presenter: viewController,
            depengency: component
        )
        interactor.listener = listener
        return CardOnFileDashboardRouter(interactor: interactor, viewController: viewController)
    }
}
