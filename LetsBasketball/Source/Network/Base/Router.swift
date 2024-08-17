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
}

extension Router: TargetType {
    var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        case .join:
            return .post
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
        }
    }
}
