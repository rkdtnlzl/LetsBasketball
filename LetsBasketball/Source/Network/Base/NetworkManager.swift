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
    
    private init() { }
    
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
}
