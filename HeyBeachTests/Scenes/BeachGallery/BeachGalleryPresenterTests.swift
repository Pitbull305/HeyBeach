//
//  BeachGalleryPresenterTests.swift
//  HeyBeachTests
//

import XCTest
@testable import HeyBeach

class BeachGalleryPresenterTests: XCTestCase {
    
    // MARK: - Properties
    var sut: BeachGalleryPresenter!
    let testBundle = Bundle(for: BeachGalleryViewControllerTests.self)
    
    // MARK: - XCTestCase
    override func setUp() {
        super.setUp()
        setupSut()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Methods
    func setupSut() {
        sut = BeachGalleryPresenter()
    }
    
    // MARK: - Spies
    class OutputSpy: BeachGalleryPresenterOut {
        var displayBeachListWasCalled = false
        var displayBeachListViewModel: BeachGalleryModel.Fetch.ViewModel.Success?
        
        var displayErrorMessageWasCalled = false
        var displayErrorMessageViewModel: BeachGalleryModel.Fetch.ViewModel.Failure?
        
        func displayBeachList(_ viewModel: BeachGalleryModel.Fetch.ViewModel.Success) {
            displayBeachListWasCalled = true
            displayBeachListViewModel = viewModel
        }
        
        func displayFetchErrorMessage(_ viewModel: BeachGalleryModel.Fetch.ViewModel.Failure) {
            displayErrorMessageWasCalled = true
            displayErrorMessageViewModel = viewModel
        }
    }
    
    // MARK: - Tests
    func testCallingPresentBeachList_callsDisplayBeachList_withCorrectData() {
        // Given
        let outputSpy = OutputSpy()
        sut.output = outputSpy
        
        let redPhoto = UIImage(named: "red.png", in: testBundle, compatibleWith: nil)!
        let greenPhoto = UIImage(named: "green.png", in: testBundle, compatibleWith: nil)!
        let bluePhoto = UIImage(named: "blue.png", in: testBundle, compatibleWith: nil)!
        let beach1 = BeachGalleryModel.Beach(image: redPhoto, title: "Red")
        let beach2 = BeachGalleryModel.Beach(image: greenPhoto, title: "Green")
        let beach3 = BeachGalleryModel.Beach(image: bluePhoto, title: "Blue")
        let beachList = [beach1, beach2, beach3]
        let response = BeachGalleryModel.Fetch.Response(beachList: beachList)
        
        // When
        sut.presentBeachList(response)
        
        // Then
        XCTAssertTrue(outputSpy.displayBeachListWasCalled)
        
        let viewModel = outputSpy.displayBeachListViewModel
        XCTAssertEqual(viewModel?.beachList[0].image, UIImage(named: "red.png", in: testBundle, compatibleWith: nil)!)
        XCTAssertEqual(viewModel?.beachList[0].title, "Red")
        XCTAssertEqual(viewModel?.beachList[1].image, UIImage(named: "green.png", in: testBundle, compatibleWith: nil)!)
        XCTAssertEqual(viewModel?.beachList[1].title, "Green")
        XCTAssertEqual(viewModel?.beachList[2].image, UIImage(named: "blue.png", in: testBundle, compatibleWith: nil)!)
        XCTAssertEqual(viewModel?.beachList[2].title, "Blue")
    }
    
    func testCallingPresentFetchError_callsDisplayErrorMessage_withCorrectData() {
        // Given
        let outputSpy = OutputSpy()
        sut.output = outputSpy
        
        // When
        sut.presentFetchError()
        
        // Then
        XCTAssertTrue(outputSpy.displayErrorMessageWasCalled)
        
        let viewModel = outputSpy.displayErrorMessageViewModel
        XCTAssertEqual(viewModel?.message, "An error has occurred, please try again later.")
    }
}
