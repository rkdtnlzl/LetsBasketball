//
//  RecentCollectionViewCell.swift
//  LetsBasketball
//
//  Created by 강석호 on 8/19/24.
//

import UIKit
import SnapKit

final class RecentCollectionViewCell: BaseCollectionViewCell {
    
    static let id = "RecentCollectionViewCell"
    
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    
    override func configureHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
    }
    
    override func configureView() {
        titleLabel.text = "지금 당장 농구할 사람 구합니다"
        titleLabel.font = UIFont(name: "Pretendard-SemiBold", size: 17)
        titleLabel.textColor = .black
        
        descriptionLabel.text = "지금 당장 당현천에서 농구할 사람 구합니다. 9시쯤에 할 예정이고 오시는분들은 전화한번만 해주세요~~"
        descriptionLabel.font = UIFont(name: "Pretendard-Regular", size: 13)
        descriptionLabel.textColor = .darkGray
        descriptionLabel.numberOfLines = 0
        
        contentView.layer.borderColor = UIColor(named: "BaseColor")?.cgColor
        contentView.layer.borderWidth = 1
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(40)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(20)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(20)
        }
    }
}
