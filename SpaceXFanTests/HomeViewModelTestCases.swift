//
//  HomeViewModelTestCases.swift
//  SpaceXFanTests
//
//  Created by ggajulapati on 24/05/21.
//

import XCTest

@testable import SpaceXFan

class HomeViewModelTestCases: XCTestCase {

    let homeViewModel = HomeViewModel()

    override class func setUp() {
    }
        
    func testTitle() {
        XCTAssertNotNil(homeViewModel.getTitleName())
        XCTAssertEqual(homeViewModel.getTitleName(), Constants.Titles.home)
    }
        
    func testSpaceRocketsListUrl() {
        XCTAssertNotNil(homeViewModel.spaceRocketsListUrl)
        XCTAssertEqual(homeViewModel.spaceRocketsListUrl, Constants.URL.spaceRocketsListUrl)
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
