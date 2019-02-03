//
//  UserDefaultsManager.swift
//  HeyBeach
//

import Foundation

class UserDefaultsManager {
    
    // MARK: - Properties
    private static let standardUserDefaults = UserDefaults.standard
    private static let tokenKey = "user_token"
    
    // MARK: - Methods
    static func storeUserToken(_ token: String) {
        standardUserDefaults.set(token, forKey: tokenKey)
    }
    
    static func getUserToken() -> String? {
        return standardUserDefaults.value(forKey: tokenKey) as? String
    }
    
    static func deleteUserToken() {
        standardUserDefaults.removeObject(forKey: tokenKey)
    }
}
