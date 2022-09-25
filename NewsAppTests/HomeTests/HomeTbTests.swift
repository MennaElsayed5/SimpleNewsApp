//
//  HomeTbTests.swift
//  NewsAppTests
//
//  Created by Menna on 25.9.22.
//

import XCTest
@testable import NewsApp
class HomeTbTests: XCTestCase {

    var sut : ListNewsViewController!
    override func setUp()  {
        super.setUp()
        sut = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ListNewsVC")
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
    func test_rendersCalles(){

        XCTAssertNotNil(sut.newsTb.numberOfRow(section:1))
    }
    func test_cellForRow(){
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.newsTb.cell(at: indexPath)
        XCTAssertNotNil(cell)
    }
    func test_didSelectedRow(){
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.newsTb.delegate?.tableView?(sut.newsTb, heightForRowAt: indexPath)
        XCTAssertNotNil(cell)
    }
    func testGetDataFromCoreData() {
        let expect = expectation(description: "response")
        sut?.getArticlesFromCoreData()
        expect.fulfill()
        waitForExpectations(timeout: 2.0)
    }
    
}
extension UITableView{
    func numberOfRow(section: Int = 0) -> Int{
        return (self.dataSource?.tableView(self, numberOfRowsInSection: section))!
    }
    func cell(at indextPath: IndexPath)->UITableViewCell{
        (self.dataSource?.tableView(self, cellForRowAt: indextPath))!
    }

    
}
