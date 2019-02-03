//
//  AuthenticationInteractor.swift
//  HeyBeach
//

import Foundation

protocol AuthenticationInteractorIn {
    func signUp(_ request: AuthenticationModel.SignUp.Request)
}

protocol AuthenticationInteractorOut {
    func presentSignUpSuccess()
    func presentSignUpFailure()
}

class AuthenticationInteractor {
    
    // MARK: - Properties
    var output: AuthenticationInteractorOut?
    var userWorker: UserWorker?
    
    // MARK: - Methods
    private func handleSignUpResponse(_ token: String?) {
        DispatchQueue.main.async {
            if let token = token {
                UserDefaultsManager.storeToken(token)
                self.output?.presentSignUpSuccess()
            }
            else {
                self.output?.presentSignUpFailure()
            }
        }
    }
}

// MARK: - AuthenticationInteractorIn
extension AuthenticationInteractor: AuthenticationInteractorIn {
    func signUp(_ request: AuthenticationModel.SignUp.Request) {
        userWorker?.signUp(email: request.email, password: request.password, completionHandler: {
            (token: String?) in
            self.handleSignUpResponse(token)
        })
    }
}
