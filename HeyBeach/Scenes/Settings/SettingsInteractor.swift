//
//  SettingsInteractor.swift
//  HeyBeach
//

import Foundation

protocol SettingsInteractorIn {
    func logout()
}

protocol SettingsInteractorOut {
    func presentLogoutSuccess()
    func presentLogoutFailure()
}

class SettingsInteractor {
    
    // MARK: - Properties
    var output: SettingsInteractorOut?
    var userWorker: UserWorker?
    
    private func handleLogoutResponse(_ success: Bool) {
        DispatchQueue.main.async {
            if success {
                UserDefaultsManager.deleteUserToken()
                self.output?.presentLogoutSuccess()
            }
            else {
                self.output?.presentLogoutFailure()
            }
        }
    }
}

// MARK: - SettingsInteractorIn
extension SettingsInteractor: SettingsInteractorIn {
    func logout() {
        guard let userToken = UserDefaultsManager.getUserToken() else { return }
        userWorker?.logout(token: userToken, completionHandler: {
            (success: Bool) in
            self.handleLogoutResponse(success)
        })
    }
}
