//
//  AdaptivePresentationControllerDelegate.swift
//  RIBsProject
//
//  Created by kimsoomin_mac2022 on 4/13/24.
//

import UIKit
/*
 인터렉터는 UIKit에 대해 모름. ( UI 관련 작업도 모두 presentor에서 진행함.)
 modal로 띄운 뷰컨을 드래그하여 닫을 때, 이벤트를 캐치하여 detach를 진행해야 하는데, 이를 인터렉터에서 하는것 보다
 인터렉터는 계속 UIKit으로 부터 분리해두고
 중간에 어댑터 클래스를 하나 만들어서 해당 클래스에서 작업할 수 있도록 한다.
 */

public protocol AdaptivePresentationControllerDelegate: AnyObject { //delegate로 사용할거라, weak으로 선언되어야함.= anyobject
    func presentationControllerDidDismiss()
}

//AdaptivePresentationControllerDelegate 받을 클래스.
//UIAdaptivePresentationControllerDelegate 대신해서 받을 객체 
public final class AdaptivePresentationControllerDelegateProxy: NSObject, UIAdaptivePresentationControllerDelegate {
    public weak var delegate: AdaptivePresentationControllerDelegate?
    
    public func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        delegate?.presentationControllerDidDismiss()
    }
}

