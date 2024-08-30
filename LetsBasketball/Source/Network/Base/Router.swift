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
    case allGetPost(product_id: String)
    case postYanong(query: PostYanongQuery)
    case likePost(post_id: String, query: LikePostQuery)
    case fetchLikePost
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
        case .allGetPost:
            return .get
        case .postYanong:
            return .post
        case .likePost:
            return .post
        case .fetchLikePost:
            return .get
        }
    }
    
    var parameters: String? {
        return nil
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .allGetPost(let product_id):
            return [URLQueryItem(name: "product_id", value: product_id)]
        default:
            return nil
        }
    }
    
    var body: Data? {
        switch self {
        case .login(let query):
            let encoder = JSONEncoder()
            return try? encoder.encode(query)
        case .join(let query):
            let encoder = JSONEncoder()
            return try? encoder.encode(query)
        case .postYanong(let query):
            let encoder = JSONEncoder()
            return try? encoder.encode(query)
        case .likePost(_, let query):
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
        case .allGetPost:
            return "/posts"
        case .postYanong:
            return "/posts"
        case .likePost(let post_id, _):
            return "/posts/\(post_id)/like"
        case .fetchLikePost:
            return "/posts/likes/me"
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
        case .allGetPost:
            return [
                Header.authorization.rawValue: UserDefaultsManager.shared.token,
                Header.contentType.rawValue: Header.json.rawValue,
                Header.refresh.rawValue: UserDefaultsManager.shared.refreshToken,
                Header.sesacKey.rawValue: APIKey.key
            ]
        case .postYanong:
            return [
                Header.authorization.rawValue: UserDefaultsManager.shared.token,
                Header.contentType.rawValue: Header.json.rawValue,
                Header.refresh.rawValue: UserDefaultsManager.shared.refreshToken,
                Header.sesacKey.rawValue: APIKey.key
            ]
        case .likePost:
            return [
                Header.authorization.rawValue: UserDefaultsManager.shared.token,
                Header.contentType.rawValue: Header.json.rawValue,
                Header.refresh.rawValue: UserDefaultsManager.shared.refreshToken,
                Header.sesacKey.rawValue: APIKey.key
            ]
        case .fetchLikePost:
            return [
                Header.authorization.rawValue: UserDefaultsManager.shared.token,
                Header.contentType.rawValue: Header.json.rawValue,
                Header.refresh.rawValue: UserDefaultsManager.shared.refreshToken,
                Header.sesacKey.rawValue: APIKey.key
            ]
        }
    }
}
