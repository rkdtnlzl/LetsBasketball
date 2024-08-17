//
//  JoinViewModel.swift
//  LetsBasketball
//
//  Created by 강석호 on 8/17/24.
//

import RxSwift
import RxCocoa

class JoinViewModel {
    
    struct Input {
        let nicknameText: ControlProperty<String>
        let emailText: ControlProperty<String>
        let passwordText: ControlProperty<String>
        let joinTap: ControlEvent<Void>
    }
    
    struct Output {
        let isJoinEnabled: Observable<Bool>
        let joinResult: Observable<Bool>
        let errorMessage: Observable<String?>
    }
    
    private let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        let data = Observable.combineLatest(input.nicknameText,
                                            input.emailText,
                                            input.passwordText
        )
        
        let isJoinEnabled = data
            .map { nickname, email, password in
                return !email.isEmpty && !password.isEmpty && !nickname.isEmpty
            }
        
        let joinResult = PublishSubject<Bool>()
        let errorMessage = PublishSubject<String?>()
        
        input.joinTap
            .withLatestFrom(data)
            .flatMapLatest { nickname, email, password -> Observable<Bool> in
                return NetworkManager.join(email: email, password: password, nick: nickname)
                    .catch { error in
                        errorMessage.onNext("회원가입 실패: \(error)")
                        return Observable.just(false)
                    }
            }
            .bind(onNext: { success in
                joinResult.onNext(success)
                if !success {
                    errorMessage.onNext("회원가입 실패")
                }
            })
            .disposed(by: disposeBag)
        
        return Output(
            isJoinEnabled: isJoinEnabled,
            joinResult: joinResult.asObservable(),
            errorMessage: errorMessage.asObservable()
        )
    }
}
