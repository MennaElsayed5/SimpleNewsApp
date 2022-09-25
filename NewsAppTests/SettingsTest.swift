//
//  SettingsTest.swift
//  NewsAppTests
//
//  Created by Menna on 25.9.22.
//

import XCTest
@testable import NewsApp
class SettingsTest: XCTestCase {

    var sut : SettingsViewController!
    override func setUp()  {
        super.setUp()
        sut = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "SettingsViewController")
        sut.loadViewIfNeeded()
    }
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    func test_viewDidLoad(){
        XCTAssertNotNil(sut)
        XCTAssertNotNil(sut.viewDidLoad)
    }
    func test_viewWillApper(){
     XCTAssertNotNil(sut.viewWillAppear(false))
    }

}
