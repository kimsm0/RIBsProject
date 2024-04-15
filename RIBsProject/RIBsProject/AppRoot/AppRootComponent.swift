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
         superPayRepository: SuperPayRepository,
         cardOnFileRepository: CardOnFileReposistory,
         rootViewController: ViewControllable
    ) {
        self.rootViewController = rootViewController
        self.cardOnFileRepository = cardOnFileRepository
        self.superPayRepository = superPayRepository
        super.init(dependency: dependency)
    }
}
