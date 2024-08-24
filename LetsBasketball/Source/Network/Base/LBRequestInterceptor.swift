//
//  LBRequestInterceptor.swift
//  LetsBasketball
//
//  Created by 강석호 on 8/22/24.
//

import UIKit
import RxSwift
import Alamofire

final class LBRequestInterceptor: RequestInterceptor {
    
    private var isRefreshingToken = false
    private var requestsToRetry: [(RetryResult) -> Void] = []
    private let disposeBag = DisposeBag()
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, any Error>) -> Void) {
        print("interceptor adapt 작동")
        let accessToken = UserDefaultsManager.shared.token
        var urlRequest = urlRequest
        urlRequest.setValue(accessToken, forHTTPHeaderField: "Authorization")
        completion(.success(urlRequest))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: any Error, completion: @escaping (RetryResult) -> Void) {
        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 419 else {
            completion(.doNotRetryWithError(error))
            return
        }
        
        requestsToRetry.append(completion)
        
        if !isRefreshingToken {
            isRefreshingToken = true
            refreshToken { [weak self] isSuccess in
                guard let self = self else { return }
                
                self.isRefreshingToken = false
                self.requestsToRetry.forEach { $0(isSuccess ? .retry : .doNotRetry) }
                self.requestsToRetry.removeAll()
            }
        }
    }
    
    func refreshToken(completion: @escaping (Bool) -> Void) {
        print("토큰 재발급 시작")
        NetworkManager.shared.postRefreshToken()
            .subscribe(onNext: { result in
                switch result {
                case .success(let data):
                    print("리프레쉬 토큰을 사용하여 토큰을 재발행하여 저장")
                    UserDefaultsManager.shared.token = data.accessToken
                    completion(true)
                case .failure(let error):
                    print("리프레시 토큰 사용 실패: \(error)")
                    self.logout()
                    completion(false)
                }
            }, onError: { error in
                print("토큰 재발급 중 오류 발생: \(error)")
                self.logout()
                completion(false)
            })
            .disposed(by: disposeBag)
        }
    
    func logout() {
        UserDefaults.standard.removeObject(forKey: "access")
        UserDefaults.standard.removeObject(forKey: "refresh")
        
        DispatchQueue.main.async {
            guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
            sceneDelegate.window?.rootViewController = UINavigationController(rootViewController: LoginViewController())
        }
    }
}
