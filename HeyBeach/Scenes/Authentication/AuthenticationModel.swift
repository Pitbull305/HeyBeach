//
//  AuthenticationModel.swift
//  HeyBeach
//

import Foundation

enum AuthenticationModel {
    
    enum SignUp {
        struct Request {
            let email: String
            let password: String
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
