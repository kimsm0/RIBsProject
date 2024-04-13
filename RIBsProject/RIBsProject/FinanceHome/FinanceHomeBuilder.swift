import ModernRIBs

protocol FinanceHomeDependency: Dependency {
  
}

//SuperPayDashboardDependency = 자식 리블렛의 디펜던시.
final class FinanceHomeComponent: Component<FinanceHomeDependency>, 
                                    SuperPayDashboardDependency,
                                  CardOnFileDashboardDependency
{
    //ReadOnlyCurrentValuePublisher 는 CurrentValuePublisher의 자식 클래스라서 자동으로 타입 클래스.
    //balance = send를 호출할 수 없음.
    var balance: ReadOnlyCurrentValuePublisher<Double> { balancePublisher }
    let cardOnFileRepository: CardOnFileReposistory
    private let balancePublisher: CurrentValuePublisher<Double>
    
    init(
        dependency: FinanceHomeDependency,
        balance: CurrentValuePublisher<Double>,
        cardOnFileRepository: CardOnFileReposistory
    ) {
        self.cardOnFileRepository = cardOnFileRepository
        self.balancePublisher = balance
        super.init(dependency: dependency)
    }
}

// MARK: - Builder

protocol FinanceHomeBuildable: Buildable {
  func build(withListener listener: FinanceHomeListener) -> FinanceHomeRouting
}

final class FinanceHomeBuilder: Builder<FinanceHomeDependency>, FinanceHomeBuildable {
    
    override init(dependency: FinanceHomeDependency) {
        super.init(dependency: dependency)
    }
    
    func build(withListener listener: FinanceHomeListener) -> FinanceHomeRouting {
        //현재 리블렛에서 생성하는것이 맞다고 판단( finance를 담당하는 "홈"
        let balancePublisher = CurrentValuePublisher<Double>(10000)
        
        let component = FinanceHomeComponent(
            dependency: dependency,
            balance: balancePublisher,
            cardOnFileRepository: CardOnFileReposistoryImp()
        )
        let viewController = FinanceHomeViewController()
        let interactor = FinanceHomeInteractor(presenter: viewController)
        interactor.listener = listener
        
        let superPayDashboardBuilder = SuperPayDashboardBuilder(dependency: component)
        let cardOnFileDashboardBuilder = CardOnFileDashboardBuilder(dependency: component)
        
        return FinanceHomeRouter(
            interactor: interactor,
            viewController: viewController, 
            superPayDashboardBuildable: superPayDashboardBuilder,
            cardOnFileDashboardBuilable: cardOnFileDashboardBuilder
        )
    }
}
