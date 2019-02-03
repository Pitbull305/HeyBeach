//
//  UserDefaultsManager.swift
//  HeyBeach
//

import Foundation

class UserDefaultsManager {
    
    // MARK: - Properties
    private static let standardUserDefaults = UserDefaults.standard
    private static let userTokenKey = "user_token"
    
    // MARK: - Methods
    static func storeUserToken(_ token: String) {
        standardUserDefaults.set(token, forKey: userTokenKey)
    }
    
    static func getUserToken() -> String? {
        return standardUserDefaults.value(forKey: userTokenKey) as? String
    }
    
    static func deleteUserToken() {
        standardUserDefaults.removeObject(forKey: userTokenKey)
    }
}
