//
//  PostYanongView.swift
//  LetsBasketball
//
//  Created by 강석호 on 8/24/24.
//

import UIKit
import SnapKit

final class PostYanongView: BaseView {
    
    private let titleLabel = UILabel()
    let titleTextField = UITextField()
    private let contentLabel = UILabel()
    let contentView = UITextView()
    private let mapLabel = UILabel()
    private let mapThumbnail = UIImageView()
    let mapButton = UIButton()
    let completeButton = UIButton()
    
    override func configureHierarchy() {
        addSubview(titleLabel)
        addSubview(titleTextField)
        addSubview(contentLabel)
        addSubview(contentView)
        addSubview(mapLabel)
        addSubview(mapThumbnail)
        mapThumbnail.addSubview(mapButton)
        addSubview(completeButton)
    }
    
    override func configureUI() {
        titleLabel.attributedText = createAttributedText(fullText: "제목*", coloredText: "*", colorName: "BaseColor")
        titleLabel.font = UIFont(name: "Pretendard-SemiBold", size: 18)
        
        titleTextField.placeholder = "최대 20자 이내 입력 가능"
        titleTextField.addLeftPadding()
        titleTextField.layer.cornerRadius = 10
        titleTextField.layer.borderColor = UIColor.gray.cgColor
        titleTextField.layer.borderWidth = 0.3
        titleTextField.backgroundColor = .white
        
        contentLabel.attributedText = createAttributedText(fullText: "본문*", coloredText: "*", colorName: "BaseColor")
        contentLabel.font = UIFont(name: "Pretendard-SemiBold", size: 18)
        
        contentView.font = UIFont(name: "Pretendard-Regular", size: 15)
        contentView.layer.cornerRadius = 10
        contentView.layer.borderColor = UIColor.gray.cgColor
        contentView.layer.borderWidth = 0.3
        contentView.backgroundColor = .white
        
        mapLabel.attributedText = createAttributedText(fullText: "농구장 위치*", coloredText: "*", colorName: "BaseColor")
        mapLabel.font = UIFont(name: "Pretendard-SemiBold", size: 18)
        
        mapThumbnail.image = UIImage(named: "MapThumbnail")
        mapThumbnail.contentMode = .scaleToFill
        mapThumbnail.layer.borderColor = UIColor.gray.cgColor
        mapThumbnail.layer.borderWidth = 0.6
        mapThumbnail.isUserInteractionEnabled = true
        
        mapButton.backgroundColor = .clear
        
        completeButton.setTitle("작성하기", for: .normal)
        completeButton.setTitleColor(.white, for: .normal)
        completeButton.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 17)
        completeButton.backgroundColor = UIColor(named: "BaseColor")
        completeButton.layer.cornerRadius = 10
    }
    
    override func configureConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        contentView.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(130)
        }
        mapLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        mapThumbnail.snp.makeConstraints { make in
            make.top.equalTo(mapLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(140)
        }
        mapButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        completeButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(80)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(48)
        }
    }
    
    func createAttributedText(fullText: String, coloredText: String, colorName: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: fullText)
        if let range = fullText.range(of: coloredText) {
            let nsRange = NSRange(range, in: fullText)
            let color = UIColor(named: colorName) ?? UIColor.black
            attributedString.addAttribute(.foregroundColor, value: color, range: nsRange)
        }
        return attributedString
    }
}
