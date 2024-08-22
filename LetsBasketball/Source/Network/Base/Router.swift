//
//  Router.swift
//  LetsBasketball
//
//  Created by 강석호 on 8/17/24.
//

import Foundation
import Alamofire

enum Router {
    case login(query: LoginQuery)
    case join(query: JoinQuery)
    case refresh
}

extension Router: TargetType {
    var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        case .join:
            return .post
        case .refresh:
            return .get
        }
    }
    
    var parameters: String? {
        return nil
    }
    
    var queryItems: [URLQueryItem]? {
        return nil
    }
    
    var body: Data? {
        switch self {
        case .login(let query):
            let encoder = JSONEncoder()
            return try? encoder.encode(query)
        case .join(let query):
            let encoder = JSONEncoder()
            return try? encoder.encode(query)
        default:
            return nil
        }
    }
    
    var baseURL: String {
        return APIUrl.baseURL + "v1"
    }
    
    var path: String {
        switch self {
        case .login:
            return "/users/login"
        case .join:
            return "/users/join"
        case .refresh:
            return "/auth/refresh"
        }
    }
    
    var header: [String: String] {
        switch self {
        case .login:
            return [
                Header.contentType.rawValue: Header.json.rawValue,
                Header.sesacKey.rawValue: APIKey.key
            ]
        case .join:
            return [
                Header.contentType.rawValue: Header.json.rawValue,
                Header.sesacKey.rawValue: APIKey.key
            ]
        case .refresh:
            return [
                Header.authorization.rawValue: UserDefaultsManager.shared.token,
                Header.contentType.rawValue: Header.json.rawValue,
                Header.refresh.rawValue: UserDefaultsManager.shared.refreshToken,
                Header.sesacKey.rawValue: APIKey.key
            ]
        }
    }
}
