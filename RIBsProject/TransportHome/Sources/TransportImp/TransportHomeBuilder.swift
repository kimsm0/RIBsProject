import ModernRIBs
import FinanceRepository
import Transport

public protocol TransportHomeDependency: Dependency {
    var superPayRepository: SuperPayRepository { get }
}

final class TransportHomeComponent: Component<TransportHomeDependency>, TransportHomeInteractorDependency {
    var superPayRepository: SuperPayRepository{
        dependency.superPayRepository
    }
}

// MARK: - Builder

//public protocol TransportHomeBuildable: Buildable {
//  func build(withListener listener: TransportHomeListener) -> ViewableRouting
//}

public final class TransportHomeBuilder: Builder<TransportHomeDependency>, TransportHomeBuildable {
    
    public override init(dependency: TransportHomeDependency) {
        super.init(dependency: dependency)
    }
    
    public func build(withListener listener: TransportHomeListener) -> ViewableRouting {
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
