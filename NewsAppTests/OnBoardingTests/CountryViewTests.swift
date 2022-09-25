//
//  CountryViewTests.swift
//  NewsAppTests
//
//  Created by Menna on 25.9.22.
//

import XCTest
@testable import NewsApp
class CountryViewTests: XCTestCase {
    var sut : CountryOnBoardingViewController!
    override func setUp()  {
        super.setUp()
        sut = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "CountryOnBoardingViewController")
        sut.loadViewIfNeeded()
    }
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    func test_viewDidLoad(){
        XCTAssertNotNil(sut)
    }
    func test_select_country(){
      let country = sut.lableCountry.text
        if country != "choose country "{
            XCTAssertNotNil(country)
        }
    }
    
}
