//
//  UtilitesTest.swift
//  NewsAppTests
//
//  Created by Menna on 25.9.22.
//

import XCTest
@testable import NewsApp
class UtilitesTest: XCTestCase {

    var sut : Utilities?
    override func setUpWithError() throws {
        sut = Utilities()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        sut = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testIsFirstTimeInApp(){
        Utilities.utilities.setIsFirstTimeInApp()
        let isFirst = Utilities.utilities.isFirstTimeInApp()
        XCTAssertTrue(isFirst)
        
    }
    func testUserCountry(){
        Utilities.utilities.addUserCountry(userCountry: "us")
       let country  = Utilities.utilities.getUserCountry()
        XCTAssertEqual(country, "us")
    }
    func testUserCatgory(){
        Utilities.utilities.addArrCotgory(userCotgory: ["sport","scienc","health"])
        let catgory = Utilities.utilities.getArrCotgory()
        XCTAssertNotNil(catgory)
    }
    func testTheme(){
      let userTheme = Utilities.utilities.theme.getUserInterfaceStyle()
        XCTAssertEqual(userTheme, .light)
    }
    
    func testShowMassage(){
        let message: () =  Utilities.utilities.showMessage(message: "massage", error: false)
        XCTAssertNotNil(message)
        
    }
    func testHandelConnection(){
        HandelConnection.handelConnection.checkNetworkConnection { isCon in
            if isCon{
                XCTAssertTrue(isCon)
            }
        }
    }
    
}
