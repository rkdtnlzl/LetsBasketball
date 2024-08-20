//
//  HomeViewModel.swift
//  LetsBasketball
//
//  Created by 강석호 on 8/19/24.
//

import RxSwift
import RxCocoa

final class HomeViewModel {
    
    struct Input {
        let yanongTapped: ControlEvent<Void>
    }
    
    struct Output {
        let navigateToYanong: Observable<Void>
    }
    
    private let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        let navigateToYanong = input.yanongTapped.asObservable()
        
        return Output(navigateToYanong: navigateToYanong)
    }
}
