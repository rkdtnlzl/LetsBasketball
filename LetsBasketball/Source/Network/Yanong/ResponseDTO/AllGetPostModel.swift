//
//  ReponseDTO.swift
//  LetsBasketball
//
//  Created by 강석호 on 8/23/24.
//

import Foundation
import Alamofire

struct AllGetPostModel: Decodable {
    let data: [AllGetPostData]
}

struct AllGetPostData: Decodable {
    let product_id: String
    let title: String
    let content: String
}
