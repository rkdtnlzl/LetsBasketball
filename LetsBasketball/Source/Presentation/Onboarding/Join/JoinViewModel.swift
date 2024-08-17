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
        let nicknameValidation: Observable<String>
    }
    
    private let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        let nicknameValidation = input.nicknameText
            .map { nickname -> String in
                if nickname.isEmpty {
                    return "닉네임을 입력해주세요"
                } else if nickname.count < 3 || nickname.count > 6 {
                    return "닉네임은 3자 이상 6자 이하로 입력해주세요"
                } else if !nickname.isValidNickname {
                    return "닉네임은 한글, 영어, 숫자만 사용 가능합니다"
                } else {
                    return "사용 가능한 닉네임입니다"
                }
            }
        let data = Observable.combineLatest(input.nicknameText,
                                            input.emailText,
                                            input.passwordText
        )
        
        let isJoinEnabled = data
            .map { nickname, email, password in
                return !email.isEmpty && !password.isEmpty && nickname.isValidNickname && nickname.count >= 3 && nickname.count <= 6
            }
        
        let joinResult = PublishSubject<Bool>()
        
        input.joinTap
            .withLatestFrom(data)
            .flatMapLatest { nickname, email, password -> Observable<Bool> in
                return OnboardingService.join(email: email, password: password, nick: nickname)
                    .catch { _ in
                        return Observable.just(false)
                    }
            }
            .bind(onNext: { success in
                joinResult.onNext(success)
            })
            .disposed(by: disposeBag)
        
        return Output(
            isJoinEnabled: isJoinEnabled,
            joinResult: joinResult.asObservable(),
            nicknameValidation: nicknameValidation
        )
    }
}
