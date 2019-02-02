//
//  BeachGalleryInteractorTests.swift
//  HeyBeachTests
//

import XCTest
@testable import HeyBeach

class BeachGalleryInteractorTests: XCTestCase {

    // MARK: - Properties
    var sut: BeachGalleryInteractor!
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
        sut = BeachGalleryInteractor()
    }
    
    // MARK: - Spies
    class OutputSpy: BeachGalleryInteractorOut {
        var presentBeachListWasCalled = false
        var presentBeachListResponse: BeachGalleryModel.Fetch.Response?
        
        func presentBeachList(_ response: BeachGalleryModel.Fetch.Response) {
            presentBeachListWasCalled = true
            presentBeachListResponse = response
        }
    }
    
    class BeachWorkerSpy: BeachWorker {
        let testBundle = Bundle(for: BeachGalleryViewControllerTests.self)
        var rawBeachListToBeReturned = [RawBeach]()
        var successToBeReturned = false
        
        override func fetchBeachList(page: Int, completionHandler: @escaping ([RawBeach], Bool) -> Void) {
            completionHandler(rawBeachListToBeReturned, successToBeReturned)
        }
        
        override func fetchBeachImage(name: String, completionHandler: @escaping (UIImage?) -> Void) {
            let image = UIImage(named: name, in: self.testBundle, compatibleWith: nil)!
            completionHandler(image)
        }
    }
    
    // MARK: - Tests
    func testCallingFetchBeachList_callsPresentBeachListInOutput_withCorrectData_whenHavingSuccess() {
        // Given
        let outputSpy = OutputSpy()
        sut.output = outputSpy
        
        let beachWorkerSpy = BeachWorkerSpy()
        sut.beachWorker = beachWorkerSpy
        
        let rawBeach1 = RawBeach(_id: "B1", name: "red.png", url: "images/red.png", width: "100", height: "200")
        let rawBeach2 = RawBeach(_id: "B2", name: "green.png", url: "images/green.png", width: "300", height: "400")
        let rawBeach3 = RawBeach(_id: "B3", name: "blue.png", url: "images/blue.png", width: "500", height: "600")
        beachWorkerSpy.rawBeachListToBeReturned = [rawBeach1, rawBeach2, rawBeach3]
        beachWorkerSpy.successToBeReturned = true
        
        // When
        sut.fetchNextBeachListPage()
        
        RunLoop.current.run(mode: RunLoop.Mode.default, before: Date(timeIntervalSinceNow: 0.1)) // Wait a little
        
        // Then
        XCTAssertTrue(outputSpy.presentBeachListWasCalled)
        
        let response = outputSpy.presentBeachListResponse
        XCTAssertEqual(response?.beachList[0].image, UIImage(named: "red.png", in: testBundle, compatibleWith: nil)!)
        XCTAssertEqual(response?.beachList[1].image, UIImage(named: "green.png", in: testBundle, compatibleWith: nil)!)
        XCTAssertEqual(response?.beachList[2].image, UIImage(named: "blue.png", in: testBundle, compatibleWith: nil)!)
    }
}
