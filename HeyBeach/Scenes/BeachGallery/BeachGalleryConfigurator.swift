//
//  BeachGalleryConfigurator.swift
//  HeyBeach
//

import Foundation

extension BeachGalleryViewController: BeachGalleryPresenterOut {
}

extension BeachGalleryInteractor: BeachGalleryViewControllerOut {
}

extension BeachGalleryPresenter: BeachGalleryInteractorOut {
}

class BeachGalleryConfigurator {
    
    // MARK: - Methods
    func configure(viewController: BeachGalleryViewController) {
        let presenter = BeachGalleryPresenter()
        presenter.output = viewController
        
        let interactor = BeachGalleryInteractor()
        interactor.output = presenter
        interactor.beachWorker = BeachWorker()
        
        viewController.output = interactor
    }
}
