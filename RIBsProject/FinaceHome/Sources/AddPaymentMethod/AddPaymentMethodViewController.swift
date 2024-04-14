//
//  AddPaymentMethodViewController.swift
//  RIBsProject
//
//  Created by kimsoomin_mac2022 on 4/13/24.
//

import ModernRIBs
import UIKit
import RIBsUtil

protocol AddPaymentMethodPresentableListener: AnyObject {
    func didTabClose()
    func didTabConfirm(num: String, cvs: String, expire: String)
}

final class AddPaymentMethodViewController: UIViewController, AddPaymentMethodPresentable, AddPaymentMethodViewControllable {

    weak var listener: AddPaymentMethodPresentableListener?
    
    private let cardNumTextField: UITextField = {
        let tf = makeTextField()
        tf.placeholder = "카드 번호"
        return tf
    }()
        
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 14
        return stackView
    }()
    
    private let securityTextField: UITextField = {
        let tf = makeTextField()
        tf.placeholder = "CVS"
        return tf
    }()
    
    private let expirationTextField: UITextField = {
        let tf = makeTextField()
        tf.placeholder = "유효 기간"
        return tf
    }()
    
    private lazy var addCardButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.roundCorners()
        btn.backgroundColor = .primaryRed
        btn.setTitle("카드 추가", for: .normal)
        btn.addTarget(self, action: #selector(addCardButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    private static func makeTextField() -> UITextField {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = .white
        tf.borderStyle = .roundedRect
        tf.keyboardType = .numberPad
        return tf
    }
    
    init(closeButtonType: DismissButtonType){
        
        super.init(nibName: nil, bundle: nil)
        layout()
        setupNavigationItem(with: closeButtonType, target: self, action: #selector(didTabClose))
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layout()
        setupNavigationItem(with: .close, target: self, action: #selector(didTabClose))
    }
    
    func layout(){
        title = "카드 추가"
        
        
        
        view.backgroundColor = .backgroundColor
        
        view.addSubview(cardNumTextField)
        view.addSubview(stackView)
        view.addSubview(addCardButton)
        
        stackView.addArrangedSubview(securityTextField)
        stackView.addArrangedSubview(expirationTextField)
                        
        cardNumTextField.snp.makeConstraints{
            $0.top.equalToSuperview().offset(40)
            $0.leading.equalToSuperview().offset(40)
            $0.trailing.equalToSuperview().offset(-40)
            $0.height.equalTo(60)
        }
                        
        stackView.snp.makeConstraints{
            $0.top.equalTo(cardNumTextField.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(40)
            $0.trailing.equalToSuperview().offset(-40)
        }
        
        securityTextField.snp.makeConstraints{
            $0.height.equalTo(60)
        }
        
        expirationTextField.snp.makeConstraints{
            $0.height.equalTo(60)
        }
        
        addCardButton.snp.makeConstraints{
            $0.top.equalTo(stackView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(40)
            $0.trailing.equalToSuperview().offset(-40)
            $0.height.equalTo(60)
        }
    }
}

extension AddPaymentMethodViewController {
    @objc
    func addCardButtonTapped(){
        if let num = cardNumTextField.text,
           let cvs = securityTextField.text,
           let expire = expirationTextField.text {
            listener?.didTabConfirm(num: num, cvs: cvs, expire: expire)
        }
    }
    
    @objc
    func didTabClose(){
        listener?.didTabClose()
    }
}
