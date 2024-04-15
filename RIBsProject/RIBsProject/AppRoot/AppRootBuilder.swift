import ModernRIBs
import UIKit
import FinanceRepository
import Finance
import AppHome
import Profile

protocol AppRootDependency: Dependency {
  
}



// MARK: - Builder

protocol AppRootBuildable: Buildable {
  func build() -> (launchRouter: LaunchRouting, urlHandler: URLHandler)
}

final class AppRootBuilder: Builder<AppRootDependency>, AppRootBuildable {
  
  override init(dependency: AppRootDependency) {
    super.init(dependency: dependency)
  }
  
  func build() -> (launchRouter: LaunchRouting, urlHandler: URLHandler) {
      let tabBar = RootTabBarController()
    
      let component = AppRootComponent(
        dependency: dependency,
        superPayRepository: SuperPayRepositoryImp(),
        cardOnFileRepository: CardOnFileReposistoryImp(),
        rootViewController: tabBar    
      )
    
    let interactor = AppRootInteractor(presenter: tabBar)
    
    let appHome = AppHomeBuilder(dependency: component)
    let financeHome = FinanceHomeBuilder(dependency: component)
    let profileHome = ProfileHomeBuilder(dependency: component)
    let router = AppRootRouter(
      interactor: interactor,
      viewController: tabBar,
      appHome: appHome,
      financeHome: financeHome,
      profileHome: profileHome
    )
    
    return (router, interactor)
  }
}
