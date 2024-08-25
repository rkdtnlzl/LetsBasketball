//
//  PostYanongViewModel.swift
//  LetsBasketball
//
//  Created by 강석호 on 8/25/24.
//

import RxSwift
import RxCocoa

final class PostYanongViewModel {
    
    struct Input {
        let titleText: ControlProperty<String>
        let contentText: ControlProperty<String>
        let product_id: Observable<String>
        let completeTap: ControlEvent<Void>
    }
    
    struct Output {
        let completeResult: Observable<[PostYanongModel]>
    }
    
    private let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        
        let data = Observable.combineLatest(input.titleText,
                                            input.contentText,
                                            input.product_id
        )
        
        let completeResult = PublishSubject<[PostYanongModel]>()
        
        input.completeTap
            .withLatestFrom(data)
            .flatMapLatest { title, content, product_id -> Observable<[PostYanongModel]> in
                let postWhole = NetworkManager.shared.postYanong(title: title, content: content, product_id: "전체")
                let postRegion = NetworkManager.shared.postYanong(title: title, content: content, product_id: "영등포구")
                
                return Observable.zip(postWhole, postRegion)
                    .map { postWholeResult, postYeongdeungpoResult in
                        return [postWholeResult, postYeongdeungpoResult]
                    }
            }
            .bind(onNext: { results in
                completeResult.onNext(results)
            })
            .disposed(by: disposeBag)
        
        return Output(completeResult: completeResult)
    }
}
