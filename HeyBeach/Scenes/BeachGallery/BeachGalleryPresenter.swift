//
//  BeachGalleryPresenter.swift
//  HeyBeach
//

import Foundation

protocol BeachGalleryPresenterIn {
    func presentBeachList(_ response: BeachGalleryModel.Fetch.Response)
}

protocol BeachGalleryPresenterOut: class {
    func displayBeachList(_ viewModel: BeachGalleryModel.Fetch.ViewModel.Success)
}

class BeachGalleryPresenter {
    
    // MARK: - Properties
    weak var output: BeachGalleryPresenterOut?
}

// MARK: - WeatherPresenterIn
extension BeachGalleryPresenter: BeachGalleryPresenterIn {
    func presentBeachList(_ response: BeachGalleryModel.Fetch.Response) {
        let viewModel = BeachGalleryModel.Fetch.ViewModel.Success(beachList: response.beachList)
        output?.displayBeachList(viewModel)
    }
}
