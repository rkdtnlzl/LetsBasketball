//
//  LoginView.swift
//  LetsBasketball
//
//  Created by 강석호 on 8/15/24.
//

import UIKit
import SnapKit

final class LoginView: BaseView {
    
    private let logoImageView = UIImageView()
    private let welcomeLabel = UILabel()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let loginButton = UIButton()
    let joinButton = UIButton()
    
    override func configureHierarchy() {
        addSubview(logoImageView)
        addSubview(welcomeLabel)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)
        addSubview(joinButton)
    }
    
    override func configureUI() {
        logoImageView.image = UIImage(named: "LBLogo")
        logoImageView.contentMode = .scaleAspectFit
        
        welcomeLabel.text = "환영합니다!"
        welcomeLabel.font = UIFont(name: "Pretendard-Bold", size: 27)
        welcomeLabel.textColor = UIColor(named: "BaseColor")
        
        emailTextField.addLeftPadding()
        emailTextField.placeholder = "이메일 입력"
        emailTextField.backgroundColor = .white
        emailTextField.layer.cornerRadius = 10
        emailTextField.layer.borderColor = UIColor.gray.cgColor
        emailTextField.layer.borderWidth = 0.7
        
        passwordTextField.addLeftPadding()
        passwordTextField.placeholder = "비밀번호 입력"
        passwordTextField.backgroundColor = .white
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.layer.borderColor = UIColor.gray.cgColor
        passwordTextField.layer.borderWidth = 0.7
        
        loginButton.setTitle("로그인하기", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 17)
        loginButton.backgroundColor = UIColor(named: "BaseColor")
        loginButton.layer.cornerRadius = 10
        
        joinButton.setTitle("회원가입하기", for: .normal)
        joinButton.setTitleColor(UIColor(named: "BaseColor"), for: .normal)
        joinButton.titleLabel?.font = UIFont(name: "Pretendard-Regular", size: 13)
        joinButton.backgroundColor = .clear
    }
    
    override func configureConstraints() {
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(130)
            make.centerX.equalToSuperview()
            make.size.equalTo(80)
        }
        welcomeLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(50)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(30)
        }
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(48)
        }
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(48)
        }
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(48)
        }
        joinButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(30)
        }
    }
}
