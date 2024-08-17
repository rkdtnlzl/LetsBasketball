//
//  JoinModel.swift
//  LetsBasketball
//
//  Created by 강석호 on 8/17/24.
//

import Foundation
import Alamofire

struct JoinModel: Decodable {
    let user_id: String
    let email: String
    let nick: String
    
    enum CodingKeys: String, CodingKey {
        case user_id = "user_id"
        case email, nick
    }
}
