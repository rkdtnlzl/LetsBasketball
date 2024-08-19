//
//  LBBoardView.swift
//  LetsBasketball
//
//  Created by 강석호 on 8/19/24.
//

import UIKit
import SnapKit

class LBBoardView: UIView {
    
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    
    init(title: String, description: String) {
        super.init(frame: .zero)
        
        titleLabel.text = title
        descriptionLabel.text = description
        
        configureHierarchy()
        configureUI()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    func configureHierarchy() {
        addSubview(titleLabel)
        addSubview(descriptionLabel)
    }
    
    func configureUI() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(named: "BaseColor")?.cgColor
        
        titleLabel.textColor = .black
        titleLabel.font = UIFont(name: "Pretendard-Bold", size: 17)
        
        descriptionLabel.textColor = .gray
        descriptionLabel.font = UIFont(name: "Pretendard-Medium", size: 13)
    }
    
    func configureConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-20)
            make.leading.equalToSuperview().inset(20)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(20)
            make.leading.equalToSuperview().inset(20)
        }
    }
}
