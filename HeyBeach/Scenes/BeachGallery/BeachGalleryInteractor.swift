//
//  BeachGalleryInteractor.swift
//  HeyBeach
//

import UIKit

protocol BeachGalleryInteractorIn {
    func fetchNextBeachListPage()
}

protocol BeachGalleryInteractorOut {
    func presentBeachList(_ response: BeachGalleryModel.Fetch.Response)
}

class BeachGalleryInteractor {
    
    // MARK: - Properties
    var output: BeachGalleryInteractorOut?
    var beachWorker: BeachWorker?
    
    // Infinite scrolling
    private var isLoadingBeachList = false
    private var currentBeachListPage = 0
    private var totalBeachListCount = 0
    private var oldBeachList = [BeachGalleryModel.Beach]()
    
    // MARK: - Methods
    private func handleFetchBeachListResponse(_ rawBeachList: [RawBeach], _ success: Bool) {
        if success {
            totalBeachListCount = rawBeachList.count
            createFetchResponse(rawBeachList, completionHandler: {
                (response: BeachGalleryModel.Fetch.Response) in
                self.isLoadingBeachList = false
                self.output?.presentBeachList(response)
            })
        }
        else {
        }
    }
    
    private func createFetchResponse(_ rawBeachList: [RawBeach], completionHandler: @escaping(_ response: BeachGalleryModel.Fetch.Response) -> Void) {
        let dispatchGroup = DispatchGroup()
        var newBeachList = [BeachGalleryModel.Beach]()
        
        for (index, rawBeach) in rawBeachList.enumerated() {
            let beach = BeachGalleryModel.Beach()
            newBeachList.append(beach)
            
            // Get image
            dispatchGroup.enter()
            beachWorker?.fetchBeachImage(name: rawBeach.name, completionHandler: {
                (image: UIImage?) in
                newBeachList[index].image = image
                dispatchGroup.leave()
            })
        }
        
        dispatchGroup.notify(queue: DispatchQueue.main) { // All responses are received
            // Create wholeBeachList containing previous pages and current page
            let wholeBeachList = self.oldBeachList + newBeachList
            
            // Update oldBeachList for next call
            self.oldBeachList = wholeBeachList
            
            completionHandler(BeachGalleryModel.Fetch.Response(beachList: wholeBeachList))
        }
    }
}

// MARK: - WeatherInteractorIn
extension BeachGalleryInteractor: BeachGalleryInteractorIn {
    func fetchNextBeachListPage() {
        if !isLoadingBeachList {
            print("Loading next page")
            isLoadingBeachList = true
            currentBeachListPage += 1
            beachWorker?.fetchBeachList(page: currentBeachListPage, completionHandler: {
                (rawBeachList: [RawBeach], success: Bool) in
                self.handleFetchBeachListResponse(rawBeachList, success)
            })
        }
    }
}