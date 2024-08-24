//
//  RegionViewModel.swift
//  LetsBasketball
//
//  Created by 강석호 on 8/24/24.
//

import RxSwift
import RxCocoa

class RegionViewModel {
    
    private let region: String
    
    init(region: String) {
        self.region = region
    }
    
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
        switch region {
        case "전체":
            NetworkManager.shared.fetchAllPost()
                .subscribe(with: self, onNext: { owner, response in
                    owner.itemsSubject.onNext(response.data)
                    owner.errorSubject.onNext(nil)
                }, onError: { owner, error in
                    owner.errorSubject.onNext(error)
                })
                .disposed(by: disposeBag)
        case "영등포구":
            NetworkManager.shared.fetchYeongdeungpoPost()
                .subscribe(with: self, onNext: { owner, response in
                    owner.itemsSubject.onNext(response.data)
                    owner.errorSubject.onNext(nil)
                }, onError: { owner, error in
                    owner.errorSubject.onNext(error)
                })
                .disposed(by: disposeBag)
        case "마포구":
            NetworkManager.shared.fetchMapoPost()
                .subscribe(with: self, onNext: { owner, response in
                    owner.itemsSubject.onNext(response.data)
                    owner.errorSubject.onNext(nil)
                }, onError: { owner, error in
                    owner.errorSubject.onNext(error)
                })
                .disposed(by: disposeBag)
        default:
            print("Unsupported region: \(region)")
        }
    }
}
