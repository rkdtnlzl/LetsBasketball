//
//  LoginViewController.swift
//  LetsBasketball
//
//  Created by 강석호 on 8/14/24.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: BaseViewController {
    deinit {
        print("deinit \(self)")
    }
    
    let loginView = LoginView()
    let viewModel = LoginViewModel()
    
    override func loadView() {
        self.view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    func bind() {
        let input = LoginViewModel.Input(
            emailText: loginView.emailTextField.rx.text.orEmpty,
            passwordText: loginView.passwordTextFeild.rx.text.orEmpty,
            loginTap: loginView.loginButton.rx.tap
        )
        
        let output = viewModel.transform(input: input)
        
        output.isLoginEnabled
            .bind(to: loginView.loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.loginResult
            .bind(with: self, onNext: { owner, success in
                if success {
                    owner.setRootViewController(HomeViewController())
                } else {
                    print("로그인 실패")
                    owner.showAlert(title: "로그인을 실패하였습니다")
                }
            })
            .disposed(by: disposeBag)
    }
}
