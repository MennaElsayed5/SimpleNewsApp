//
//  CatgoryViewTest.swift
//  NewsAppTests
//
//  Created by Menna on 25.9.22.
//

import XCTest
@testable import NewsApp
class CatgoryViewTest: XCTestCase {

    var sut : CatgoryOnboardingViewController!
    override func setUp()  {
        super.setUp()
        sut = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "CatgoryOnboardingViewController")
        sut.loadViewIfNeeded()
    }
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    func test_viewDidLoad(){
        XCTAssertNotNil(sut)
    }
    func test_rendersCalles(){
        XCTAssertNotNil(sut.catgoryTb.numberRowFav(section:0))
    }
    func test_cellForRow(){
     //   var catgoryArr = ["business","entertainment","general","health","science","sports","technology"]
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.catgoryTb.cellRowCatgory(at: indexPath)
        XCTAssertNotNil(cell)
    }
    func test_didSelectedRow(){
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.catgoryTb.delegate?.tableView?(sut.catgoryTb, heightForRowAt: indexPath)
        XCTAssertNotNil(cell)
    }
    
}
extension UITableView{
    func numberRowcCatgory(section: Int = 0) -> Int{
        return (self.dataSource?.tableView(self, numberOfRowsInSection: section))!
    }
    func cellRowCatgory(at indextPath: IndexPath)->UITableViewCell{
        (self.dataSource?.tableView(self, cellForRowAt: indextPath))!
    }
}
