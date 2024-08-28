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
    let regionView = UIView()
    let regionLabel = UILabel()
    let mapThumbnail = UIImageView()
    let mapButton = UIButton()
    
    override func configureHierarchy() {
        addSubview(titleLabel)
        addSubview(userLabel)
        addSubview(contentLabel)
        addSubview(regionView)
        regionView.addSubview(regionLabel)
        addSubview(mapThumbnail)
        mapThumbnail.addSubview(mapButton)
    }
    
    override func configureUI() {
        regionView.backgroundColor = UIColor(hexCode: "F7ECEC")
        regionView.layer.cornerRadius = 10
        
        regionLabel.font = UIFont(name: "Pretendard-SemiBold", size: 14)
        regionLabel.textColor = UIColor(named: "BaseColor")
        regionLabel.textAlignment = .center
        
        titleLabel.font = UIFont(name: "Pretendard-SemiBold", size: 22)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 2
        
        userLabel.font = UIFont(name: "Pretendard-Regular", size: 13)
        userLabel.textColor = .black
        
        contentLabel.font = UIFont(name: "Pretendard-SemiBold", size: 14)
        contentLabel.textColor = .black
        contentLabel.numberOfLines = 4
        
        mapThumbnail.image = UIImage(named: "MapThumbnail")
        mapThumbnail.contentMode = .scaleToFill
        mapThumbnail.layer.borderColor = UIColor.gray.cgColor
        mapThumbnail.layer.borderWidth = 0.6
        mapThumbnail.isUserInteractionEnabled = true
        
        mapButton.backgroundColor = .clear
    }
    
    override func configureConstraints() {
        regionView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(130)
            make.leading.equalToSuperview().inset(20)
            make.height.equalTo(30)
            make.width.equalTo(60)
        }
        regionLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(regionView.snp.bottom).offset(15)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(35)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        
        mapThumbnail.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(140)
        }
        mapButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
