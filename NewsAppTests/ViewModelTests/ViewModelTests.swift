//
//  ViewModelTests.swift
//  NewsAppTests
//
//  Created by Menna on 25.9.22.
//

import XCTest
@testable import NewsApp
import RxSwift
class ViewModelTests: XCTestCase {

    var sut : NewsProtocolViewModel?
    var disBag : DisposeBag?
    override func setUpWithError() throws {
        sut = NewsViewModel()
       disBag = DisposeBag()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        sut = nil
      //  disBag = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testCheckNewsInCoreData(){
        let isFav: ()? = sut?.checkNewsInCoreData(data: "data", auther: "auther")
        XCTAssertTrue((isFav != nil))
    }
    func testSaveoCoreData(){
        do{try sut?.saveoCoreData(title: "news", img: "image", desc: "description", source: "youtube", data: "1999", auther: "menna", completion: { isSaved in
            if isSaved {
                XCTAssertTrue(isSaved)
            }
            else{
                XCTFail()
            }
        }) }catch{}
    }
    func testGetAllnewsInCoreData(){
        do{try sut?.getAllnewsInCoreData(completion: { isGet in
            if(isGet){
                XCTAssertTrue(isGet)
            }else{
                XCTFail()
            }
        })}catch{}
    }
    func testRemoveNewsFromCoreDatat(){
        do{try sut?.removeNewsFromCoreDatat(title: "news", completionHandler: { isRemove in
            if (isRemove){
                XCTAssertTrue(isRemove)
            }else{
                XCTFail()
            }
        })}catch{}
    }
    func testCheckConnection(){
        let isCon: ()?=sut?.checkConnection()
        XCTAssertTrue((isCon != nil))
        XCTAssertFalse((isCon == nil))
    }
    func testOpenWebsite(){
        let expect = expectation(description: "response")
        sut?.openWebsite(url: "http://www.abc.net.au/news")
        expect.fulfill()
        waitForExpectations(timeout: 2.0)
        
    }
    func testSearchNews(){
        let expect = expectation(description: "load response")
        sut?.searchObservable.asObservable().subscribe{
            result in
            expect.fulfill()
            XCTAssertNotNil(result.element)
        }.disposed(by: disBag!)
        sut?.searchArticales(text: "news")
        waitForExpectations(timeout: 5)
    }
    func testGetNewsFromApi(){
        let expect = expectation(description: "load response")
        sut?.newsObservable.asObservable().subscribe{
            result in
            expect.fulfill()
            XCTAssertNotNil(result.element)
        }.disposed(by: disBag!)
        sut?.getNewsFromApi(countryName: "us", catgoryId: "sport")
        waitForExpectations(timeout: 5)
    }
    
}
