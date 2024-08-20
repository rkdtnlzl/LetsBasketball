//
//  LoginViewModel.swift
//  LetsBasketball
//
//  Created by 강석호 on 8/15/24.
//

import RxSwift
import RxCocoa

class LoginViewModel {
    
    struct Input {
        let emailText: ControlProperty<String>
        let passwordText: ControlProperty<String>
        let loginTap: ControlEvent<Void>
        let joinTap: ControlEvent<Void>
    }
    
    struct Output {
        let isLoginEnabled: Observable<Bool>
        let loginResult: Observable<Bool>
    }
    
    private let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        let data = Observable.combineLatest(input.emailText, input.passwordText)
        
        let isLoginEnabled = data
            .map { email, password in
                return !email.isEmpty && !password.isEmpty
            }
        
        let loginResult = PublishSubject<Bool>()
        
        input.loginTap
            .withLatestFrom(data)
            .flatMapLatest { email, password -> Observable<Bool> in
                return NetworkManager.shared.login(email: email, password: password)
                    .catch { _ in
                        return Observable.just(false)
                    }
            }
            .bind(onNext: { success in
                loginResult.onNext(success)
            })
            .disposed(by: disposeBag)
        
        input.joinTap
            .subscribe()
            .disposed(by: disposeBag)
        
        return Output(
            isLoginEnabled: isLoginEnabled,
            loginResult: loginResult.asObservable()
        )
    }
}
