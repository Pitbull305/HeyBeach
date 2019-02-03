//
//  SettingsModel.swift
//  HeyBeach
//

import Foundation

enum SettingsModel {
    
    enum Logout {
        struct Request {
        }
        
        struct Response {
        }
        
        enum ViewModel {
            struct Success {
            }
            
            struct Failure {
                let message: String
            }
        }
    }
}
