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
        let passwordConfirmText: ControlProperty<String>
        let joinTap: ControlEvent<Void>
    }
    
    struct Output {
        let isJoinEnabled: Observable<Bool>
        let joinResult: Observable<Bool>
        let nicknameValidation: Observable<String>
        let emailValidation: Observable<String>
        let passwordValidation: Observable<String>
        let passwordConfirmValidation: Observable<String>
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
        
        let emailValidation = input.emailText
            .map { email -> String in
                if email.isEmpty {
                    return "이메일을 입력해주세요"
                } else if !email.isValidEmail {
                    return "올바른 이메일 형식이 아닙니다"
                } else {
                    return "사용 가능한 이메일입니다"
                }
            }
        
        let passwordValidation = input.passwordText
            .map { password -> String in
                if password.isEmpty {
                    return "비밀번호를 입력해주세요"
                } else if !password.isValidPassword {
                    return "비밀번호는 6자 이상, 영어와 숫자 조합이어야 합니다"
                } else {
                    return "사용 가능한 비밀번호입니다"
                }
            }
        
        let passwordConfirmValidation = Observable.combineLatest(input.passwordText, input.passwordConfirmText)
            .map { password, confirmPassword -> String in
                if confirmPassword.isEmpty {
                    return "비밀번호 확인을 입력해주세요"
                } else if password != confirmPassword {
                    return "비밀번호가 일치하지 않습니다"
                } else {
                    return "비밀번호가 일치합니다"
                }
            }
        
        let data = Observable.combineLatest(input.nicknameText,
                                            input.emailText,
                                            input.passwordText,
                                            input.passwordConfirmText
        )
        
        let isJoinEnabled = data
            .map { nickname, email, password, confirmPassword in
                return email.isValidEmail && password.isValidPassword && nickname.isValidNickname && password == confirmPassword
            }
        
        let joinResult = PublishSubject<Bool>()
        
        input.joinTap
            .withLatestFrom(data)
            .flatMapLatest { nickname, email, password, _ -> Observable<Bool> in
                return NetworkManager.shared.join(email: email, password: password, nick: nickname)
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
            nicknameValidation: nicknameValidation,
            emailValidation: emailValidation,
            passwordValidation: passwordValidation,
            passwordConfirmValidation: passwordConfirmValidation
        )
    }
}
