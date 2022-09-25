//
//  FacVCTest.swift
//  NewsAppTests
//
//  Created by Menna on 25.9.22.
//

import XCTest
@testable import NewsApp
class FacVCTest: XCTestCase {

    var sut : FavViewController?
    override func setUpWithError() throws {
        sut = FavViewController()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        sut = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testDeleteItemFromCoreData(){
        let expect = expectation(description: "response")
        sut?.deleteItemFromCoreData(index: [1])
        expect.fulfill()
        waitForExpectations(timeout: 2.0)
    }

}
