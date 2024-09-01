//
//  RecentTableViewCell.swift
//  LetsBasketball
//
//  Created by 강석호 on 9/1/24.
//

import UIKit
import SnapKit

class RecentTableViewCell: BaseTableViewCell {
    
    static let id = "RecentTableViewCell"
    
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
    
    func configure(with post: RecentTable) {
        titleLabel.text = post.title
        descriptionLabel.text = post.content
    }
}

