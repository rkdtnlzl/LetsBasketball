//
//  HomeView.swift
//  LetsBasketball
//
//  Created by 강석호 on 8/19/24.
//

import UIKit
import SnapKit

final class HomeView: BaseView {
    
    private let logoLabel = UILabel()
    private let logoImageView = UIImageView()
    private let searchBar = LBSearchView()
    private let boardLabel = UILabel()
    private let yanongBoard = LBBoardView(title: "야농 게시판",
                                            description: "야외 농구 모집하기")
    private let infoBoard = LBBoardView(title: "정보 게시판",
                                            description: "농구 정보 공유하기")
    
    private lazy var boardStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [yanongBoard, infoBoard])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let yanongButton = UIButton()
    private let recentLabel = UILabel()
    let recentMoreButton = UIButton()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    
    func layout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 150, height: 180)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        return layout
    }
    
    override func configureHierarchy() {
        addSubview(logoLabel)
        addSubview(logoImageView)
        addSubview(searchBar)
        addSubview(boardLabel)
        addSubview(boardStackView)
        addSubview(recentLabel)
        addSubview(recentMoreButton)
        addSubview(collectionView)
        
        yanongBoard.addSubview(yanongButton)
    }
    
    override func configureUI() {
        logoLabel.text = "농구 커뮤니티 야농"
        logoLabel.font = UIFont(name: "Pretendard-Black", size: 24)
        logoLabel.textColor = UIColor(named: "BaseColor")
        
        logoImageView.image = UIImage(named: "LBLogo2")
        logoImageView.contentMode = .scaleAspectFit
        
        boardLabel.text = "게시판"
        boardLabel.font = UIFont(name: "Pretendard-Bold", size: 20)
        boardLabel.textColor = UIColor(named: "BaseColor")
        
        recentLabel.text = "최근 본 게시글"
        recentLabel.font = UIFont(name: "Pretendard-Bold", size: 20)
        recentLabel.textColor = UIColor(named: "BaseColor")
        
        yanongButton.backgroundColor = .clear
        
        recentMoreButton.setImage(UIImage(systemName: "plus"), for: .normal)
        recentMoreButton.tintColor = UIColor(named: "BaseColor")
        
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(RecentCollectionViewCell.self, forCellWithReuseIdentifier: RecentCollectionViewCell.id)
    }
    
    override func configureConstraints() {
        logoLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(80)
            make.leading.equalToSuperview().inset(20)
        }
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(77)
            make.leading.equalTo(logoLabel.snp.trailing).offset(10)
            make.size.equalTo(35)
        }
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(logoLabel.snp.bottom).offset(60)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(55)
        }
        boardLabel.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(40)
            make.leading.equalToSuperview().inset(20)
        }
        boardStackView.snp.makeConstraints { make in
            make.top.equalTo(boardLabel.snp.bottom).offset(15)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(120)
        }
        yanongButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        recentLabel.snp.makeConstraints { make in
            make.top.equalTo(infoBoard.snp.bottom).offset(40)
            make.leading.equalToSuperview().inset(20)
        }
        recentMoreButton.snp.makeConstraints { make in
            make.top.equalTo(infoBoard.snp.bottom).offset(40)
            make.trailing.equalToSuperview().inset(20)
            make.size.equalTo(20)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(recentLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview()
            make.height.equalTo(180)
        }
    }
}
