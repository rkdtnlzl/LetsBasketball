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
        let titleText: Observable<String>
        let contentText: Observable<String>
        let product_id: Observable<String>
        let latitude: Observable<String>
        let longitude: Observable<String>
        let completeTap: Observable<Void>
    }
    
    struct Output {
        let completeResult: Observable<[PostYanongModel]>
        let alertMessage: Observable<String>
    }
    
    private let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        
        let isValidInput = Observable.combineLatest(input.titleText, input.contentText, input.product_id, input.latitude, input.longitude)
            .map { title, content, product_id, latitude, longitude in
                return (title: title,
                        content: content,
                        product_id: product_id,
                        latitude: latitude,
                        longitude: longitude,
                        isValid: !title.isEmpty && !content.isEmpty && !product_id.isEmpty)
            }
            .share(replay: 1)
        
        let completeResult = PublishSubject<[PostYanongModel]>()
        let alertMessage = PublishSubject<String>()
        
        input.completeTap
            .withLatestFrom(isValidInput)
            .subscribe(onNext: { data in
                if data.isValid {
                    let title = data.title
                    let content = data.content
                    let product_id = data.product_id
                    let latitude = data.latitude
                    let longitude = data.longitude
                    
                    Observable.combineLatest(NetworkManager.shared.postYanong(title: title, content: content, product_id: "전체", latitude: latitude, longitude: longitude),
                                             NetworkManager.shared.postYanong(title: title, content: content, product_id: product_id, latitude: latitude, longitude: longitude))
                    .map { postWholeResult, postRegionResult in
                        return [postWholeResult, postRegionResult]
                    }
                    .bind(to: completeResult)
                    .disposed(by: self.disposeBag)
                } else {
                    if data.title.isEmpty {
                        alertMessage.onNext("제목을 입력해주세요.")
                    } else if data.content.isEmpty {
                        alertMessage.onNext("본문을 입력해주세요.")
                    } else {
                        alertMessage.onNext("지역을 선택해주세요.")
                    }
                }
            })
            .disposed(by: disposeBag)
        
        return Output(completeResult: completeResult.asObservable(),
                      alertMessage: alertMessage.asObservable())
    }
}
