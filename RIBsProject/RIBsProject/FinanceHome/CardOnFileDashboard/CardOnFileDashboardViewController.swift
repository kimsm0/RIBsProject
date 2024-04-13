//
//  CardOnFileDashboardViewController.swift
//  RIBsProject
//
//  Created by kimsoomin_mac2022 on 4/13/24.
//

import ModernRIBs
import UIKit

protocol CardOnFileDashboardPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class CardOnFileDashboardViewController: UIViewController, CardOnFileDashboardPresentable, CardOnFileDashboardViewControllable {
    
    weak var listener: CardOnFileDashboardPresentableListener?
    
    private let headerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.text = "슈퍼페이 잔고"
        return label
    }()
    
    private lazy var seeAllButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("전체보기", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(seeAllButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    private let cardOnFileStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }()
    
    private lazy var plusPaymentMethodButton: AddPaymentMethodButton = {
        let button = AddPaymentMethodButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.roundCorners()
        button.backgroundColor = .systemGray4
        button.addTarget(self, action: #selector(addPaymentMethodButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    
    init(){
        super.init(nibName: nil, bundle: nil)
        layout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layout()
    }
    
    func layout(){
        view.addSubview(headerStackView)
        view.addSubview(cardOnFileStackView)
                
        headerStackView.addArrangedSubview(titleLabel)
        headerStackView.addArrangedSubview(seeAllButton)
        
        
        
        headerStackView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        cardOnFileStackView.snp.makeConstraints{
            $0.top.equalTo(headerStackView.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview()
        }
        
        plusPaymentMethodButton.snp.makeConstraints{
            $0.height.equalTo(60)
        }
    }
}
extension CardOnFileDashboardViewController {
    @objc
    func seeAllButtonDidTap(){
        
    }
    
    @objc
    func addPaymentMethodButtonDidTap(){
        
    }
    
    func update(with viewModels: [PaymentMethodViewModel]) {
        cardOnFileStackView.arrangedSubviews.forEach{ $0.removeFromSuperview() }
        
        //[PaymentMethodViewModel] -> [PaymentMethodView] : map/flatmap으로 간결하게 표현
        let views = viewModels.map(PaymentMethodView.init)
        views.forEach{
            $0.roundCorners()
            cardOnFileStackView.addArrangedSubview($0)
        }
        cardOnFileStackView.addArrangedSubview(plusPaymentMethodButton)
        
        _ = views.map { $0.snp.makeConstraints{ $0.height.equalTo(60)} }
        
    }
}
