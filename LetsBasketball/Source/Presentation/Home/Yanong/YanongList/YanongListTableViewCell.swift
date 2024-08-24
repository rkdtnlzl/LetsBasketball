//
//  YanongListTableViewCell.swift
//  LetsBasketball
//
//  Created by 강석호 on 8/22/24.
//

import UIKit
import SnapKit

class YanongListTableViewCell: BaseTableViewCell {
    
    static let id = "YanongTableViewCell"
    
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    
    override func configureHierarchy() {
        addSubview(titleLabel)
        addSubview(descriptionLabel)
    }
    
    override func configureView() {
        titleLabel.font = UIFont(name: "Pretendard-SemiBold", size: 17)
        titleLabel.textColor = .black
        
        descriptionLabel.font = UIFont(name: "Pretendard-Regular", size: 15)
        descriptionLabel.textColor = .black
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview().inset(20)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
    }
    
    func configure(with model: AllGetPostData) {
        titleLabel.text = model.title
        descriptionLabel.text = model.content
    }
}
