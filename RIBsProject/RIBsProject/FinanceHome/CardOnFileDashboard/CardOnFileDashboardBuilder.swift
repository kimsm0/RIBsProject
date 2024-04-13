//
//  CardOnFileDashboardBuilder.swift
//  RIBsProject
//
//  Created by kimsoomin_mac2022 on 4/13/24.
//

import ModernRIBs

protocol CardOnFileDashboardDependency: Dependency {
    var cardOnFileRepository: CardOnFileReposistory { get }
}

final class CardOnFileDashboardComponent: Component<CardOnFileDashboardDependency>, CardOnFileDashboardInteractorDependency {

    var cardOnFileRepository: CardOnFileReposistory {
        dependency.cardOnFileRepository
    }
}

// MARK: - Builder

protocol CardOnFileDashboardBuildable: Buildable {
    func build(withListener listener: CardOnFileDashboardListener) -> CardOnFileDashboardRouting
}

final class CardOnFileDashboardBuilder: Builder<CardOnFileDashboardDependency>, CardOnFileDashboardBuildable {

    override init(dependency: CardOnFileDashboardDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: CardOnFileDashboardListener) -> CardOnFileDashboardRouting {
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
