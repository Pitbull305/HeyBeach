//
//  SettingsPresenter.swift
//  HeyBeach
//

import Foundation

protocol SettingsPresenterIn {
    func presentLogoutSuccess()
    func presentLogoutFailure()
}

protocol SettingsPresenterOut: class {
    func handleLogoutSuccess()
    func displayLogoutErrorMessage(_ viewModel: SettingsModel.Logout.ViewModel.Failure)
}

class SettingsPresenter {
    
    // MARK: - Properties
    weak var output: SettingsPresenterOut?
}

// MARK: - SettingsPresenterIn
extension SettingsPresenter: SettingsPresenterIn {
    func presentLogoutSuccess() {
        output?.handleLogoutSuccess()
    }
    
    func presentLogoutFailure() {
        let viewModel = SettingsModel.Logout.ViewModel.Failure(message: "An error has occurred during Logout, please try again later.")
        output?.displayLogoutErrorMessage(viewModel)
    }
}
