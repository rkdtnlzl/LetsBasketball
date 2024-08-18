//
//  String+.swift
//  LetsBasketball
//
//  Created by 강석호 on 8/17/24.
//

import Foundation

extension String {
    var isValidNickname: Bool {
        let nicknameRegex = "^[가-힣A-Za-z0-9]+$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", nicknameRegex)
        return predicate.evaluate(with: self)
    }
    
    var isValidEmail: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return predicate.evaluate(with: self)
    }
}
