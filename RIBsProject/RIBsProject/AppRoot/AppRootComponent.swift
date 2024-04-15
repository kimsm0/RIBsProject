//
//  AppRootComponent.swift
//  RIBsProject
//
//  Created by kimsoomin_mac2022 on 4/15/24.
//

import ModernRIBs
import UIKit
import FinanceRepository
import Finance
import AppHome
import Profile
import Transport
import TransportImp
import Topup
import TopupImp
import AddPaymentMethod
import AddPaymentMethodImp
import Network
import NetworkImp

final class AppRootComponent: Component<AppRootDependency>, AppHomeDependency, FinanceHomeDependency, ProfileHomeDependency, TransportHomeDependency, TopupDependency, AddPaymentMethodDependency  {
    
    lazy var addPaymentMethodBuilder: AddPaymentMethodBuildable = {
        return AddPaymentMethodBuilder(dependency: self)
    }()
    
    var topupBaseViewController: ViewControllable {
        rootViewController.topViewControllable
    }
    var superPayRepository: SuperPayRepository
    var cardOnFileRepository: CardOnFileReposistory
    
    lazy var topupBuildable: TopupBuildable = {
        return TopupBuilder(dependency: self)
    }()
    
    lazy var transportHomeBuildable: TransportHomeBuildable = {
        return TransportHomeBuilder(dependency: self)
    }()
            
    private let rootViewController: ViewControllable
    
    init(dependency: AppRootDependency,
         rootViewController: ViewControllable
    ) {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [RIBsProjectAppURLProtocol.self]
        setupURLProtocol()
        let network = NetworkImp(session: URLSession(configuration: config))
        
        self.rootViewController = rootViewController
        self.cardOnFileRepository = CardOnFileReposistoryImp(network: network, baseURL: BaseURL().financeBaseURL)
        self.cardOnFileRepository.fetch()
        self.superPayRepository = SuperPayRepositoryImp(network: network, baseURL: BaseURL().financeBaseURL)
        super.init(dependency: dependency)
    }
}
