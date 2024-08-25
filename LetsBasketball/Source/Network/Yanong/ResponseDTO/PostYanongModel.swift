//
//  PostYanongModel.swift
//  LetsBasketball
//
//  Created by 강석호 on 8/25/24.
//

import Foundation
import Alamofire

struct PostYanongModel: Decodable {
    let title: String
    let content: String
    let product_id: String
}
