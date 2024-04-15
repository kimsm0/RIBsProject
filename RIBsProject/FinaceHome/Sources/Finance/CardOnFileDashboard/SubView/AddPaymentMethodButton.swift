//
//  AddPaymentMethodButton.swift
//  RIBsProject
//
//  Created by kimsoomin_mac2022 on 4/13/24.
//

import UIKit

final class AddPaymentMethodButton: UIControl {
    
    private let plusIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "plus",
                                  withConfiguration: UIImage.SymbolConfiguration(pointSize: 24, weight: .semibold))
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    init(){
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layout()
    }
    
    private func layout(){
        addSubview(plusIcon)
        
        plusIcon.snp.makeConstraints{
            $0.center.equalToSuperview()
        }
    }
}
