//
//  FavoriteViewModel.swift
//  LetsBasketball
//
//  Created by 강석호 on 8/30/24.
//

import RxSwift
import RxCocoa

class FavoriteViewModel {
    
    struct Input {
        let fetchTrigger: Observable<Void>
    }
    
    struct Output {
        let items: Observable<[AllGetPostData]>
        let error: Observable<Error?>
    }
    
    private let itemsSubject = PublishSubject<[AllGetPostData]>()
    private let errorSubject = PublishSubject<Error?>()
    
    private let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        input.fetchTrigger
            .subscribe(with: self, onNext: { owner, _ in
                owner.fetchData()
            })
            .disposed(by: disposeBag)
        
        return Output(
            items: itemsSubject.asObservable(),
            error: errorSubject.asObservable()
        )
    }
    
    private func fetchData() {
        NetworkManager.shared.fetchLikePost()
            .subscribe(with: self, onNext: { owner, response in
                owner.itemsSubject.onNext(response.data)
                owner.errorSubject.onNext(nil)
            }, onError: { owner, error in
                owner.errorSubject.onNext(error)
            })
            .disposed(by: disposeBag)
    }
}
