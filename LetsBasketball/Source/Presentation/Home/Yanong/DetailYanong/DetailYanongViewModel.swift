//
//  DetailYanongViewModel.swift
//  LetsBasketball
//
//  Created by 강석호 on 8/29/24.
//

import Foundation
import RxSwift
import RxCocoa

class DetailYanongViewModel {
    
    struct Input {
        let heartButtonClicked: ControlEvent<Void>
    }
    
    struct Output {
        let isLiked: Observable<Bool>
        let error: Observable<Error?>
    }
    
    private let isLikedSubject = BehaviorSubject<Bool>(value: false)
    private let errorSubject = BehaviorSubject<Error?>(value: nil)
    private let disposeBag = DisposeBag()
    var post_id: String?
    
    func transform(input: Input) -> Output {
        if let post_id = post_id {
            let initialLike = fetchLike(post_id: post_id)
            isLikedSubject.onNext(initialLike)
        }
        
        input.heartButtonClicked
            .withLatestFrom(isLikedSubject)
            .flatMapLatest { [weak self] isLiked in
                return self?.toggleLikeStatus(isLiked: isLiked) ?? Observable.just(isLiked)
            }
            .bind(to: isLikedSubject)
            .disposed(by: disposeBag)
        
        
        let isLiked = isLikedSubject.asObservable()
        let error = errorSubject.asObservable()
        
        return Output(isLiked: isLiked, error: error)
    }
    
    private func toggleLikeStatus(isLiked: Bool) -> Observable<Bool> {
        guard let post_id = post_id else {
            return Observable.just(isLiked)
        }
        
        return NetworkManager.shared.likedPost(post_id: post_id, like_status: !isLiked)
            .map { _ in
                let newLikeStatus = !isLiked
                self.saveLike(post_id: post_id, isLiked: newLikeStatus)
                return newLikeStatus
            }
            .catch { [weak self] error in
                self?.handleError(error)
                return Observable.just(isLiked)
            }
    }
    
    private func handleError(_ error: Error) {
        errorSubject.onNext(error)
    }
    
    private func fetchLike(post_id: String) -> Bool {
        let likedPosts = UserDefaults.standard.dictionary(forKey: "likedPosts") as? [String: Bool] ?? [:]
        return likedPosts[post_id] ?? false
    }
    
    private func saveLike(post_id: String, isLiked: Bool) {
        var likedPosts = UserDefaults.standard.dictionary(forKey: "likedPosts") as? [String: Bool] ?? [:]
        likedPosts[post_id] = isLiked
        UserDefaults.standard.setValue(likedPosts, forKey: "likedPosts")
    }
}
