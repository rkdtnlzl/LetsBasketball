//
//  LoginViewModel.swift
//  LetsBasketball
//
//  Created by 강석호 on 8/15/24.
//

import RxSwift
import RxCocoa

class LoginViewModel {
    private let disposeBag = DisposeBag()
    
    let loginTapped = PublishSubject<Void>()
    let joinTapped = PublishSubject<Void>()
    
    let navigateToMain = PublishSubject<Void>()
    let navigateToJoin = PublishSubject<Void>()
    
    init() {
        loginTapped
            .bind(to: navigateToMain)
            .disposed(by: disposeBag)
        
        joinTapped
            .bind(to: navigateToJoin)
            .disposed(by: disposeBag)
    }
}
