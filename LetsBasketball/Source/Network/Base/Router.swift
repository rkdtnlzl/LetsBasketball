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
}

extension Router: TargetType {
    var method: HTTPMethod {
        switch self {
        case .login:
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
        }
    }
    
    var header: [String: String] {
        switch self {
        case .login:
            return [
                Header.contentType.rawValue: Header.json.rawValue,
                Header.sesacKey.rawValue: APIKey.key
            ]
        }
    }
}
