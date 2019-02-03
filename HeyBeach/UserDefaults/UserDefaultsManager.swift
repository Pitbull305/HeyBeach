//
//  UserDefaultsManager.swift
//  HeyBeach
//

import Foundation

class UserDefaultsManager {
    
    // MARK: - Properties
    private static let standardUserDefaults = UserDefaults.standard
    private let token = "user_token"
    
    // MARK: - Methods
    static func storeToken(_ token: String) {
        standardUserDefaults.set(token, forKey: token)
    }
}
