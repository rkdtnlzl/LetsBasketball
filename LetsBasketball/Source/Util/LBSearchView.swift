//
//  LBSearchView.swift
//  LetsBasketball
//
//  Created by 강석호 on 8/19/24.
//

import UIKit
import SnapKit

class LBSearchView: BaseView {

    let searchImageView = UIImageView()
    let searchPlaceHolder = UILabel()
    
    override func configureHierarchy() {
        addSubview(searchImageView)
        addSubview(searchPlaceHolder)
    }
    
    override func configureUI() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(named: "BaseColor")?.cgColor
        
        searchImageView.image = UIImage(systemName: "magnifyingglass")
        searchImageView.tintColor = UIColor(named: "BaseColor")
        
        searchPlaceHolder.text = "원하는 게시글을 찾아보세요"
        searchPlaceHolder.textColor = UIColor(named: "BaseColor")
        searchPlaceHolder.font = .systemFont(ofSize: 15)
    }
    
    override func configureConstraints() {
        searchImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.size.equalTo(20)
        }
        
        searchPlaceHolder.snp.makeConstraints { make in
            make.leading.equalTo(searchImageView.snp.trailing).offset(10)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-10)
        }
    }
}
