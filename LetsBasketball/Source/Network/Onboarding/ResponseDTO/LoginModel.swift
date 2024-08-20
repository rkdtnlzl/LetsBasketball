//
//  LoginModel.swift
//  LetsBasketball
//
//  Created by 강석호 on 8/17/24.
//

import Foundation
import Alamofire

struct LoginModel: Decodable {
    let user_id: String
    let email: String
    let nick: String
    let profileImage: String?
    let accessToken: String
    let refreshToken: String
    
    enum CodingKeys: String, CodingKey {
        case user_id = "user_id"
        case email, nick
        case profileImage = "profileImage"
        case accessToken = "accessToken"
        case refreshToken = "refreshToken"
    }
}
