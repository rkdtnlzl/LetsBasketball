//
//  KakaoAddressResponse.swift
//  LetsBasketball
//
//  Created by 강석호 on 8/28/24.
//

import Foundation

struct KakaoAddressResponse: Decodable {
    let documents: [KakaoAddressDocument]
}

struct KakaoAddressDocument: Decodable {
    let address: KakaoAddress?
}

struct KakaoAddress: Decodable {
    let region_2depth_name: String
}
