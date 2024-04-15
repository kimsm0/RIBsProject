import ModernRIBs
import AddPaymentMethodImp
import FinanceRepository
import CombineUtil
import Topup

public protocol FinanceHomeDependency: Dependency {
    var cardOnFileRepository: CardOnFileReposistory { get }
    var superPayRepository: SuperPayRepository { get }
    var topupBuildable: TopupBuildable { get }
}

//SuperPayDashboardDependency = 자식 리블렛의 디펜던시.
final class FinanceHomeComponent: Component<FinanceHomeDependency>, 
                                    SuperPayDashboardDependency,
                                  CardOnFileDashboardDependency,
                                  AddPaymentMethodDependency
{
    //ReadOnlyCurrentValuePublisher 는 CurrentValuePublisher의 자식 클래스라서 자동으로 타입 클래스.
    //balance = send를 호출할 수 없음.
    var balance: ReadOnlyCurrentValuePublisher<Double> { superPayRepository.balance }
    var cardOnFileRepository: CardOnFileReposistory { dependency.cardOnFileRepository }
    var superPayRepository: SuperPayRepository { dependency.superPayRepository }
    var topupBuildable: TopupBuildable { dependency.topupBuildable }
//    init(
//        dependency: FinanceHomeDependency,
//        cardOnFileRepository: CardOnFileReposistory,
//        topupBaseViewController: ViewControllable
//    ) {
//        self.cardOnFileRepository = cardOnFileRepository
//        self.topupBaseViewController = topupBaseViewController
//        super.init(dependency: dependency)
//    }
}

// MARK: - Builder

public protocol FinanceHomeBuildable: Buildable {
  func build(withListener listener: FinanceHomeListener) -> ViewableRouting
}

public final class FinanceHomeBuilder: Builder<FinanceHomeDependency>, FinanceHomeBuildable {
    
    public override init(dependency: FinanceHomeDependency) {
        super.init(dependency: dependency)
    }
    
    public func build(withListener listener: FinanceHomeListener) -> ViewableRouting {
        //현재 리블렛에서 생성하는것이 맞다고 판단( finance를 담당하는 "홈"
        let viewController = FinanceHomeViewController()
        
        let component = FinanceHomeComponent(
            dependency: dependency
//            cardOnFileRepository: CardOnFileReposistoryImp(),            
//            topupBaseViewController: viewController
        )
        
        let interactor = FinanceHomeInteractor(presenter: viewController)
        interactor.listener = listener
        
        let superPayDashboardBuilder = SuperPayDashboardBuilder(dependency: component)
        let cardOnFileDashboardBuilder = CardOnFileDashboardBuilder(dependency: component)
        let addPaymentMethodBuilder = AddPaymentMethodBuilder(dependency: component)
//        let topupBuildable = TopupBuilder(dependency: component)
        
        return FinanceHomeRouter(
            interactor: interactor,
            viewController: viewController, 
            superPayDashboardBuildable: superPayDashboardBuilder,
            cardOnFileDashboardBuilable: cardOnFileDashboardBuilder,
            addPaymentMethodBuildable: addPaymentMethodBuilder,
            topupBuildable: component.topupBuildable
        )
    }
}
