//
//  AuthenticationPresenter.swift
//  HeyBeach
//

import Foundation

protocol AuthenticationPresenterIn {
    func presentSignUpSuccess()
}

protocol AuthenticationPresenterOut: class {
    func handleSignUpSuccess()
}

class AuthenticationPresenter {
    
    // MARK: - Properties
    weak var output: AuthenticationPresenterOut?
}

// MARK: - AuthenticationPresenterIn
extension AuthenticationPresenter: AuthenticationPresenterIn {
    func presentSignUpSuccess() {
        output?.handleSignUpSuccess()
    }
}
