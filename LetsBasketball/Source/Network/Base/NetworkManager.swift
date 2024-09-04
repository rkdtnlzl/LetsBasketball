//
//  NetworkManager.swift
//  LetsBasketball
//
//  Created by 강석호 on 8/20/24.
//

import Foundation
import Alamofire
import RxSwift

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let session: Session
    
    private init() {
        session = Session(interceptor: LBRequestInterceptor())
    }
    
    // MARK: 로그인
    func login(email: String, password: String) -> Observable<Bool> {
        return Observable.create { observer in
            do {
                let query = LoginQuery(email: email, password: password)
                let request = try Router.login(query: query).asURLRequest()
                
                AF.request(request)
                    .responseDecodable(of: LoginModel.self) { response in
                        switch response.result {
                        case .success(let success):
                            print(success)
                            UserDefaultsManager.shared.token = success.accessToken
                            UserDefaultsManager.shared.refreshToken = success.refreshToken
                            print("성공적 토큰 저장")
                            observer.onNext(true)
                            observer.onCompleted()
                            
                        case .failure(let failure):
                            print(failure)
                            observer.onNext(false)
                            observer.onCompleted()
                        }
                    }
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    // MARK: 회원가입
    func join(email: String, password: String, nick: String) -> Observable<Bool> {
        return Observable.create { observer in
            do {
                let query = JoinQuery(email: email, password: password, nick: nick)
                let request = try Router.join(query: query).asURLRequest()
                
                AF.request(request)
                    .responseDecodable(of: JoinModel.self) { response in
                        switch response.result {
                        case .success(let success):
                            print(success)
                            observer.onNext(true)
                            observer.onCompleted()
                            
                        case .failure(let failure):
                            print(failure)
                            observer.onNext(false)
                            observer.onCompleted()
                        }
                    }
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    // MARK: 토큰 재발급
    func postRefreshToken() -> Observable<Result<RefreshModel, Error>> {
        return Observable.create { observer in
            do {
                let request = try Router.refresh.asURLRequest()
                self.session.request(request)
                    .responseDecodable(of: RefreshModel.self) { response in
                        switch response.result {
                        case .success(let success):
                            UserDefaultsManager.shared.token = success.accessToken
                            observer.onNext(.success(success))
                            observer.onCompleted()
                        case .failure(let error):
                            observer.onNext(.failure(error))
                            observer.onCompleted()
                        }
                    }
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    // MARK: 전체 포스트 불러오기
    func fetchAllPost() -> Observable<AllGetPostModel> {
        return Observable.create { observer in
            do {
                let request = try Router.allGetPost(product_id: "전체").asURLRequest()
                
                self.session.request(request)
                    .responseDecodable(of: AllGetPostModel.self) { response in
                        switch response.result {
                        case .success(let success):
                            print(success)
                            observer.onNext(success)
                            observer.onCompleted()
                            
                        case .failure(let failure):
                            print(failure)
                            observer.onError(failure)
                        }
                    }
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    // MARK: 영등포구 포스트 불러오기
    func fetchYeongdeungpoPost() -> Observable<AllGetPostModel> {
        return Observable.create { observer in
            do {
                let request = try Router.allGetPost(product_id: "영등포구").asURLRequest()
                
                self.session.request(request)
                    .responseDecodable(of: AllGetPostModel.self) { response in
                        switch response.result {
                        case .success(let success):
                            print(success)
                            observer.onNext(success)
                            observer.onCompleted()
                            
                        case .failure(let failure):
                            print(failure)
                            observer.onError(failure)
                        }
                    }
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    // MARK: 마포구 포스트 불러오기
    func fetchMapoPost() -> Observable<AllGetPostModel> {
        return Observable.create { observer in
            do {
                let request = try Router.allGetPost(product_id: "마포구").asURLRequest()
                
                self.session.request(request)
                    .responseDecodable(of: AllGetPostModel.self) { response in
                        switch response.result {
                        case .success(let success):
                            print(success)
                            observer.onNext(success)
                            observer.onCompleted()
                            
                        case .failure(let failure):
                            print(failure)
                            observer.onError(failure)
                        }
                    }
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    // MARK: 게시글 작성
    func postYanong(title: String, content: String, product_id: String, latitude: String, longitude: String) -> Observable<PostYanongModel> {
        return Observable.create { observer in
            do {
                let query = PostYanongQuery(title: title, content: content, product_id: product_id, content1: latitude, content2: longitude)
                let request = try Router.postYanong(query: query).asURLRequest()
                
                self.session.request(request)
                    .responseDecodable(of: PostYanongModel.self) { response in
                        switch response.result {
                        case .success(let success):
                            observer.onNext(success)
                            observer.onCompleted()
                            
                        case .failure(let failure):
                            print(failure)
                            observer.onError(failure)
                        }
                    }
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    // MARK: 게시글 좋아요
    func likedPost(post_id: String, like_status: Bool) -> Observable<LikePostModel> {
        return Observable.create { observer in
            do {
                let query = LikePostQuery(like_status: like_status)
                let request = try Router.likePost(post_id: post_id, query: query).asURLRequest()
                
                self.session.request(request)
                    .responseDecodable(of: LikePostModel.self) { response in
                        switch response.result {
                        case .success(let success):
                            print(response)
                            observer.onNext(success)
                            observer.onCompleted()
                            
                        case .failure(let failure):
                            print(failure)
                            observer.onError(failure)
                        }
                    }
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    // MARK: 좋아요 게시글 조회
    func fetchLikePost() -> Observable<AllGetPostModel> {
        return Observable.create { observer in
            do {
                let request = try Router.fetchLikePost.asURLRequest()
                
                self.session.request(request)
                    .responseDecodable(of: AllGetPostModel.self) { response in
                        switch response.result {
                        case .success(let success):
                            print(success)
                            observer.onNext(success)
                            observer.onCompleted()
                            
                        case .failure(let failure):
                            print(failure)
                            observer.onError(failure)
                        }
                    }
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    // MARK: 결제 영수증 검증
    func payValidation(imp_uid: String, post_id: String) -> Observable<PayValidationModel> {
        return Observable.create { observer in
            do {
                let query = PayValidationQuery(imp_uid: imp_uid, post_id: post_id)
                let request = try Router.payValidation(query: query).asURLRequest()
                
                AF.request(request)
                    .responseDecodable(of: PayValidationModel.self) { response in
                        switch response.result {
                        case .success(let success):
                            print(success)
                            observer.onNext(success)
                            observer.onCompleted()
                            
                        case .failure(let failure):
                            print(failure)
                            observer.onError(failure)
                        }
                    }
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
}
