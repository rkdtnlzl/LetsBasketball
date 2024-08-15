//
//  UserDefaultsManager.swift
//  LetsBasketball
//
//  Created by 강석호 on 8/15/24.
//

import Foundation

final class UserDefaultsManager {
    
    private enum UserDefaultKey: String {
        case access
        case refresh
    }
    
    static let shared = UserDefaultsManager()
    
    private init() { }
    
    var token: String {
        get {
            UserDefaults.standard.string(forKey: UserDefaultKey.access.rawValue) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultKey.access.rawValue)
        }
    }
    
    var refreshToken: String {
        get {
            UserDefaults.standard.string(forKey: UserDefaultKey.refresh.rawValue) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultKey.refresh.rawValue)
        }
    }
}
