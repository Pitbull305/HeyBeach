//
//  SettingsConfigurator.swift
//  HeyBeach
//

import Foundation

extension SettingsViewController: SettingsPresenterOut {
}

extension SettingsInteractor: SettingsViewControllerOut {
}

extension SettingsPresenter: SettingsInteractorOut {
}

class SettingsConfigurator {
    
    // MARK: - Methods
    func configure(viewController: SettingsViewController) {
        let presenter = SettingsPresenter()
        presenter.output = viewController
        
        let interactor = SettingsInteractor()
        interactor.output = presenter
        interactor.userWorker = UserWorker()
        
        viewController.output = interactor
    }
}
