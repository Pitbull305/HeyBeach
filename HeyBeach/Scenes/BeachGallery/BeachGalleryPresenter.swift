//
//  BeachGalleryPresenter.swift
//  HeyBeach
//

import Foundation

protocol BeachGalleryPresenterIn {
    func presentBeachList(_ response: BeachGalleryModel.Fetch.Response)
    func presentFetchError()
}

protocol BeachGalleryPresenterOut: class {
    func displayBeachList(_ viewModel: BeachGalleryModel.Fetch.ViewModel.Success)
    func displayFetchErrorMessage(_ viewModel: BeachGalleryModel.Fetch.ViewModel.Failure)
}

class BeachGalleryPresenter {
    
    // MARK: - Properties
    weak var output: BeachGalleryPresenterOut?
}

// MARK: - BeachGalleryPresenterIn
extension BeachGalleryPresenter: BeachGalleryPresenterIn {
    func presentBeachList(_ response: BeachGalleryModel.Fetch.Response) {
        let viewModel = BeachGalleryModel.Fetch.ViewModel.Success(beachList: response.beachList)
        output?.displayBeachList(viewModel)
    }
    
    func presentFetchError() {
        let viewModel = BeachGalleryModel.Fetch.ViewModel.Failure(message: "An error has occurred, please try again later.")
        output?.displayFetchErrorMessage(viewModel)
    }
}
