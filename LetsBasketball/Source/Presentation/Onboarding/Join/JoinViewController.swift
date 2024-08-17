//
//  JoinViewController.swift
//  LetsBasketball
//
//  Created by 강석호 on 8/15/24.
//

import UIKit

final class JoinViewController: BaseViewController {
    deinit {
        print("deinit \(self)")
    }
    
    let joinView = JoinView()
    let viewModel = JoinViewModel()
    
    override func loadView() {
        self.view = joinView
    }
    
    override func configureNavigation() {
        navigationItem.title = "회원가입"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    func bind() {
        let input = JoinViewModel.Input(
            nicknameText: joinView.nicknameTextField.rx.text.orEmpty,
            emailText: joinView.emailTextField.rx.text.orEmpty,
            passwordText: joinView.passwordTextField.rx.text.orEmpty,
            joinTap: joinView.joinButton.rx.tap
        )
        
        let output = viewModel.transform(input: input)
        
        output.isJoinEnabled
            .bind(to: joinView.joinButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.nicknameValidation
            .bind(to: joinView.nicknameValid.rx.text)
            .disposed(by: disposeBag)
        
        output.joinResult
            .bind(with: self, onNext: { owner, success in
                if success {
                    owner.showAlert(title: "회원가입에 성공했습니다")
                } else {
                    owner.showAlert(title: "회원가입에 실패했습니다")
                }
            })
            .disposed(by: disposeBag)
    }
}
