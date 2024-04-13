import Foundation
import ModernRIBs

protocol AppRootRouting: ViewableRouting {
  func attachTabs()
}

protocol AppRootPresentable: Presentable {
  var listener: AppRootPresentableListener? { get set }
  // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol AppRootListener: AnyObject {
  // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class AppRootInteractor: PresentableInteractor<AppRootPresentable>, AppRootInteractable, AppRootPresentableListener, URLHandler {
    
    weak var router: AppRootRouting?
    weak var listener: AppRootListener?
    
    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: AppRootPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    //viewdidload와 비슷한 역할
    //리블렛이 처음 트리에 붙여질 때, 부모 리블렛에 attach가 되면서 활성화된 시점에 호출됨.
    override func didBecomeActive() {
        super.didBecomeActive()
        
        router?.attachTabs()
    }
    
    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func handle(_ url: URL) {
        
        
    }
}
