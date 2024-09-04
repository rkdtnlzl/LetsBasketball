//
//  PayDTO.swift
//  LetsBasketball
//
//  Created by 강석호 on 9/4/24.
//

import Foundation
import Alamofire

struct PayValidationModel: Decodable {
    let buyer_id: String
    let post_id: String
    let merchant_uid: String
    let productName: String
    let price: Int
    let paidAt: String
}
