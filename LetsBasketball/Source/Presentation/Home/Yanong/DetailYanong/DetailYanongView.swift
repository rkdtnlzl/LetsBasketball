//
//  DetailYanongView.swift
//  LetsBasketball
//
//  Created by 강석호 on 8/25/24.
//

import UIKit
import SnapKit

final class DetailYanongView: BaseView {
    
    let titleLabel = UILabel()
    let userLabel = UILabel()
    let contentLabel = UILabel()
    
    override func configureHierarchy() {
        addSubview(titleLabel)
        addSubview(userLabel)
        addSubview(contentLabel)
    }
    
    override func configureUI() {
        titleLabel.font = UIFont(name: "Pretendard-SemiBold", size: 22)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 2
        
        userLabel.font = UIFont(name: "Pretendard-Regular", size: 13)
        userLabel.textColor = .black
        
        contentLabel.font = UIFont(name: "Pretendard-SemiBold", size: 14)
        contentLabel.textColor = .black
        contentLabel.numberOfLines = 4
    }
    
    override func configureConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(130)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(50)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
    }
}
