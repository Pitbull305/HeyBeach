//
//  AuthenticationPresenter.swift
//  HeyBeach
//

import Foundation

protocol AuthenticationPresenterIn {
    func presentSignUpSuccess()
    func presentSignUpFailure()
}

protocol AuthenticationPresenterOut: class {
    func handleSignUpSuccess()
    func displaySignUpErrorMessage(_ viewModel: AuthenticationModel.SignUp.ViewModel.Failure)
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
    
    func presentSignUpFailure() {
        let viewModel = AuthenticationModel.SignUp.ViewModel.Failure(message: "An error during SignUp has occurred, please check your internet connection or try again with a different email.")
        output?.displaySignUpErrorMessage(viewModel)
    }
}
