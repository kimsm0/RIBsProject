import ModernRIBs

protocol TransportHomeDependency: Dependency {
    var superPayRepository: SuperPayRepository { get }
}

final class TransportHomeComponent: Component<TransportHomeDependency>, TransportHomeInteractorDependency {
    var superPayRepository: SuperPayRepository{
        dependency.superPayRepository
    }
}

// MARK: - Builder

protocol TransportHomeBuildable: Buildable {
  func build(withListener listener: TransportHomeListener) -> TransportHomeRouting
}

final class TransportHomeBuilder: Builder<TransportHomeDependency>, TransportHomeBuildable {
    
    override init(dependency: TransportHomeDependency) {
        super.init(dependency: dependency)
    }
    
    func build(withListener listener: TransportHomeListener) -> TransportHomeRouting {
        _ = TransportHomeComponent(dependency: dependency)
        
        let viewController = TransportHomeViewController()
        
        let component = TransportHomeComponent(dependency: dependency)
        
        let interactor = TransportHomeInteractor(
            presenter: viewController,
            depengency: component
        )
        interactor.listener = listener
        
        return TransportHomeRouter(
            interactor: interactor,
            viewController: viewController
        )
    }
    
}
