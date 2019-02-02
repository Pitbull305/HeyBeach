//
//  BeachGalleryViewControllerTests.swift
//  HeyBeachTests
//

import XCTest
@testable import HeyBeach

class BeachGalleryViewControllerTests: XCTestCase {
    
    // MARK: - Properties
    var sut: BeachGalleryViewController!
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
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        sut = mainStoryboard.instantiateViewController(withIdentifier: "BeachGalleryViewController") as? BeachGalleryViewController
        UIApplication.shared.keyWindow?.rootViewController = sut
    }
    
    func getBeachCellForItemAtPosition(_ position: Int) -> BeachCell? {
        let indexPath = IndexPath(item: position, section: 0)
        return sut.collectionView.cellForItem(at: indexPath) as? BeachCell
    }
    
    // MARK: - Tests
    func testCallingDisplayBeachList_displaysCorrectData() {
        // Given
        let redPhoto = UIImage(named: "red.png", in: testBundle, compatibleWith: nil)!
        let greenPhoto = UIImage(named: "green.png", in: testBundle, compatibleWith: nil)!
        let bluePhoto = UIImage(named: "blue.png", in: testBundle, compatibleWith: nil)!
        let beach1 = BeachGalleryModel.Beach(image: redPhoto)
        let beach2 = BeachGalleryModel.Beach(image: greenPhoto)
        let beach3 = BeachGalleryModel.Beach(image: bluePhoto)
        let beachList = [beach1, beach2, beach3]
        let viewModel = BeachGalleryModel.Fetch.ViewModel.Success(beachList: beachList)
        
        // When
        sut.displayBeachList(viewModel)
        
        // Then
        RunLoop.main.run(until: Date(timeIntervalSinceNow: 0.1))
        
        XCTAssertEqual(sut.collectionView.numberOfSections, 1)
        XCTAssertEqual(sut.collectionView.numberOfItems(inSection: 0), 3)
        
        let cell1 = getBeachCellForItemAtPosition(0)
        XCTAssertEqual(cell1?.imageView.image, redPhoto)
        
        let cell2 = getBeachCellForItemAtPosition(1)
        XCTAssertEqual(cell2?.imageView.image, greenPhoto)
        
        let cell3 = getBeachCellForItemAtPosition(2)
        XCTAssertEqual(cell3?.imageView.image, bluePhoto)
    }
}
