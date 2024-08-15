//
//  HTTPHeaderFieldKey.swift
//  LetsBasketball
//
//  Created by 강석호 on 8/15/24.
//

import Foundation

enum HTTPHeaderFieldKey: String {
    case authorization = "Authorization"
    case sesacKey = "SesacKey"
    case refresh = "Refresh"
    case contentType = "Content-Type"
    case json = "application/json"
    case multipart = "multipart/form-data"
}
