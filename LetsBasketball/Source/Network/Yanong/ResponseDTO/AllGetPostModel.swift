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
    let post_id: String
    let product_id: String
    let title: String
    let content: String
    let content1: String?
    let content2: String?
}
