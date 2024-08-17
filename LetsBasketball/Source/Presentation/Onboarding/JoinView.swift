//
//  JoinView.swift
//  LetsBasketball
//
//  Created by 강석호 on 8/15/24.
//

import UIKit
import SnapKit

final class JoinView: BaseView {
    
    let nicknameLabel = UILabel()
    let nicknameTextField = UITextField()
    let emailLabel = UILabel()
    let emailTextField = UITextField()
    let passwordLabel = UILabel()
    let passwordTextField = UITextField()
    let passwordConfirmTextField = UITextField()
    let joinButton = UIButton()
    
    override func configureHierarchy() {
        addSubview(nicknameLabel)
        addSubview(nicknameTextField)
        addSubview(emailLabel)
        addSubview(emailTextField)
        addSubview(passwordLabel)
        addSubview(passwordTextField)
        addSubview(passwordConfirmTextField)
        addSubview(joinButton)
    }
    
    override func configureUI() {
        nicknameLabel.text = "닉네임"
        nicknameLabel.font = UIFont(name: "Pretendard-Regular", size: 15)
        nicknameLabel.textColor = UIColor(named: "BaseColor")
        
        nicknameTextField.addLeftPadding()
        nicknameTextField.placeholder = "닉네임 입력"
        nicknameTextField.backgroundColor = .white
        nicknameTextField.layer.cornerRadius = 10
        nicknameTextField.layer.borderColor = UIColor.gray.cgColor
        nicknameTextField.layer.borderWidth = 0.7
        
        emailLabel.text = "이메일"
        emailLabel.font = UIFont(name: "Pretendard-Regular", size: 15)
        emailLabel.textColor = UIColor(named: "BaseColor")
        
        emailTextField.addLeftPadding()
        emailTextField.placeholder = "이메일 입력"
        emailTextField.backgroundColor = .white
        emailTextField.layer.cornerRadius = 10
        emailTextField.layer.borderColor = UIColor.gray.cgColor
        emailTextField.layer.borderWidth = 0.7
        
        passwordLabel.text = "비밀번호"
        passwordLabel.font = UIFont(name: "Pretendard-Regular", size: 15)
        passwordLabel.textColor = UIColor(named: "BaseColor")
        
        passwordTextField.addLeftPadding()
        passwordTextField.placeholder = "새 비밀번호 입력"
        passwordTextField.backgroundColor = .white
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.layer.borderColor = UIColor.gray.cgColor
        passwordTextField.layer.borderWidth = 0.7
        
        passwordConfirmTextField.addLeftPadding()
        passwordConfirmTextField.placeholder = "새 비밀번호 확인"
        passwordConfirmTextField.backgroundColor = .white
        passwordConfirmTextField.layer.cornerRadius = 10
        passwordConfirmTextField.layer.borderColor = UIColor.gray.cgColor
        passwordConfirmTextField.layer.borderWidth = 0.7
        
        joinButton.setTitle("회원가입 완료", for: .normal)
        joinButton.setTitleColor(.white, for: .normal)
        joinButton.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 17)
        joinButton.backgroundColor = UIColor(named: "BaseColor")
        joinButton.layer.cornerRadius = 10
    }
    
    override func configureConstraints() {
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(120)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(20)
        }
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(48)
        }
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom).offset(40)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(20)
        }
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(48)
        }
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(40)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(20)
        }
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(48)
        }
        passwordConfirmTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(48)
        }
        joinButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(80)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(48)
        }
    }
}
