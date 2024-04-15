//
//  PaymentMethodView.swift
//  RIBsProject
//
//  Created by kimsoomin_mac2022 on 4/13/24.
//

import UIKit
import FinanceEntity

final class PaymentMethodView: UIView {
    
    private let nameLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    init(_ viewModel: PaymentMethodViewModel){
        super.init(frame: .zero)
        layout()
        nameLable.text = viewModel.name
        subTitleLabel.text = viewModel.digits
        backgroundColor = viewModel.color
    }
    init(){
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layout()
    }
    
    private func layout(){
        addSubview(nameLable)
        addSubview(subTitleLabel)
        
        nameLable.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(24)
            $0.centerY.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints{
            $0.trailing.equalToSuperview().offset(-24)
            $0.centerY.equalToSuperview()
        }
    }
}
