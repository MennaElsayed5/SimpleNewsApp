//
//  SearchVCTest.swift
//  NewsAppTests
//
//  Created by Menna on 25.9.22.
//

import XCTest
@testable import NewsApp
class SearchVCTest: XCTestCase {

    var sut : SearchViewController?
    override func setUpWithError() throws {
        super.setUp()
        sut = SearchViewController()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSaveToCoreData(){
        let expect = expectation(description: "response")
        sut?.saveToCoreData(indexPath: [1])
        expect.fulfill()
        waitForExpectations(timeout: 2.0)
    }
    func testDeleteItemFromCoreData(){
        let expect = expectation(description: "response")
        sut?.deleteItemFromCoreData(index: [1])
        expect.fulfill()
        waitForExpectations(timeout: 2.0)
    }
    func testCheckIsFav(){
        let expect = expectation(description: "response")
        sut?.checkIsFav(indexPath: [1])
        expect.fulfill()
        waitForExpectations(timeout: 2.0)
        
    }
    func testSearch(){
        let expect = expectation(description: "response")
        sut?.searchRequest()
        expect.fulfill()
        waitForExpectations(timeout: 2.0)
    }
    func testPullRefresh(){
        let expect = expectation(description: "response")
        sut?.pullToRefresh()
        expect.fulfill()
        waitForExpectations(timeout: 4.0)
    }
    func testCheckNetwork(){
        let expect = expectation(description: "response")
        sut?.checkNetwork()
        expect.fulfill()
        waitForExpectations(timeout: 2.0)
    }
    

}
