//
//  AuthenticationPresenter.swift
//  HeyBeach
//

import Foundation

protocol AuthenticationPresenterIn {
    func presentSignUpSuccess()
    func presentSignUpFailure()
    func presentSignInSuccess()
    func presentSignInFailure()
}

protocol AuthenticationPresenterOut: class {
    func handleSignUpSuccess()
    func displaySignUpErrorMessage(_ viewModel: AuthenticationModel.SignUp.ViewModel.Failure)
    func handleSignInSuccess()
    func displaySignInErrorMessage(_ viewModel: AuthenticationModel.SignIn.ViewModel.Failure)
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
        let viewModel = AuthenticationModel.SignUp.ViewModel.Failure(message: "An error during Sign up has occurred, please check your internet connection or try again with a different email.")
        output?.displaySignUpErrorMessage(viewModel)
    }
    
    func presentSignInSuccess() {
        output?.handleSignInSuccess()
    }
    
    func presentSignInFailure() {
        let viewModel = AuthenticationModel.SignUp.ViewModel.Failure(message: "An error during Sign in has occurred, please check your internet connection and your credentials.")
        output?.displaySignUpErrorMessage(viewModel)
    }
}
