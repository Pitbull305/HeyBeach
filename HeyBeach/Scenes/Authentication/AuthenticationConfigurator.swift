//
//  AuthenticationConfigurator.swift
//  HeyBeach
//

import Foundation

extension AuthenticationViewController: AuthenticationPresenterOut {
}

extension AuthenticationInteractor: AuthenticationViewControllerOut {
}

extension AuthenticationPresenter: AuthenticationInteractorOut {
}

class AuthenticationConfigurator {
    
    // MARK: - Methods
    func configure(viewController: AuthenticationViewController) {
        let presenter = AuthenticationPresenter()
        presenter.output = viewController
        
        let interactor = AuthenticationInteractor()
        interactor.output = presenter
        interactor.userWorker = UserWorker()
        
        viewController.output = interactor
    }
}
