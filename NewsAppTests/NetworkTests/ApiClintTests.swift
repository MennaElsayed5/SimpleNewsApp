//
//  ApiClintTests.swift
//  NewsAppTests
//
//  Created by Menna on 24.9.22.
//

import XCTest
@testable import NewsApp
class ApiClintTests: XCTestCase {
    var sut:APIClint!
    override func setUpWithError() throws {
        sut = APIClint()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        sut = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testGetNews(){
        let promise = XCTestExpectation(description: "get news")
        var responseError: Error?
        var responseNews: [Article]?
        guard let bundle = Bundle.unitTest.path(forResource: "stub", ofType: "json")
        else {
            XCTFail("Error Not FOund")
            return
        }
 
        sut.getNews(countryName: bundle, catgoryId: bundle) { result in
            switch result {
            case .success(let news):
                responseNews = news.articles!
            case .failure(let error):
                responseError = error
            }
            promise.fulfill()

        }
        wait(for: [promise], timeout: 2)
        XCTAssertNil(responseError)
        XCTAssertNotNil(responseNews)
    }
    func testSearchArticales(){
        let promise = XCTestExpectation(description: "search news")
        var responseError: Error?
        var responseNews: [Article]?
        sut.searchArticales(text: "news") { result in
            switch result{
            case .success(let news):
                responseNews = news.articles!
            case .failure(let error):
                responseError = error
            }
            promise.fulfill()
            
        }
        wait(for: [promise], timeout: 2)
        XCTAssertNil(responseError)
        XCTAssertNotNil(responseNews)
    }

}
