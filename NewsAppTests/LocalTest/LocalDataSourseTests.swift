//
//  LocalDataSourseTests.swift
//  NewsAppTests
//
//  Created by Menna on 25.9.22.
//

import XCTest
@testable import NewsApp
import CoreData
class LocalDataSourseTests: XCTestCase {
    var sut : LocalDataSourcable?
    override func setUpWithError() throws {
        sut = LocalDataSource(appDelegate: (UIApplication.shared.delegate as? AppDelegate)!)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        sut = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
//    func testArticles(){
//        let expect = expectation(description: "core data")
//        let mockCoreData = MockCoreData(appDelegate: ((UIApplication.shared.delegate as? AppDelegate)!))
//
//        do{  try mockCoreData.saveoCoreData(title: "title", img: "img", desc: "desc", source: "source", data: "date", auther: "auther")} catch {}
//        do { try  mockCoreData.saveoCoreData(title: "title2", img: "img2", desc: "desc2", source: "source2", data: "date2", auther: "auther2") } catch{}
//        expect.fulfill()
//        waitForExpectations(timeout: 1)
//        XCTAssertNotNil(expect)
////        do{ let articles = try mockCoreData.getArticleFromCoreData()
////            expect.fulfill()
////            waitForExpectations(timeout: 1)
////            XCTAssertEqual(articles.count, 2)
////
////        } catch {}
//     //   do{try mockCoreData.removeArticleFromCoreData(articleTitle: "title")} catch{}
//     //   expect.fulfill()
//     //   waitForExpectations(timeout: 1)
////        do{ let articles = try mockCoreData.getArticleFromCoreData()
////            expect.fulfill()
////            waitForExpectations(timeout: 1)
////            XCTAssertEqual(articles.count, 1)
////
////        } catch {}
////
//    }
    func testSaveToCoreData(){
        let expect = expectation(description: "saved")
        do { try sut?.saveoCoreData(title: "title3", img: "img3", desc: "desc3", source: "source3", data: "2022", auther: "auther") } catch{}
        expect.fulfill()
        waitForExpectations(timeout: 1)
        XCTAssertNotNil(expect)
    }
    func testRemoveFromCoreData(){
        let expect = expectation(description: "remove")
        do { try sut?.removeArticleFromCoreData(articleTitle: "title3")
            expect.fulfill()
            waitForExpectations(timeout: 1)
        }catch{}
    }
    func testGetFromCoreData(){
        let expect = expectation(description: "get")
        do {  let articles = try sut?.getArticleFromCoreData()
            expect.fulfill()
            waitForExpectations(timeout: 1)
            XCTAssertEqual(articles?.count, 0)
        } catch{}
    
    }
    func testIsFavouriteArticle(){
        let expect = expectation(description: "is fav")
        do{let isFav = try sut?.isFavouriteArticle(data: "2022", auther: "auther")
            expect.fulfill()
            waitForExpectations(timeout: 1)
            XCTAssertTrue(isFav == false)
        }catch{}
    }


}
