//
//  TwitSplitTests.swift
//  TwitSplitTests
//
//  Created by LinhLe on 4/10/18.
//  Copyright © 2018 LinhLe. All rights reserved.
//

import XCTest
@testable import TwitSplit

class TwitSplitTests: XCTestCase {
    var composingModelTest: ComposingViewModel!
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        composingModelTest = ComposingViewModel()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        composingModelTest = nil
    }
    
    func testSplitMessageSuccessCaseSuccess20characters() {
        let message = "123456789 123456789."
        let result = composingModelTest.split(message: message)
        let compareResult = ["123456789 123456789."]
        for text in result {
            print(text)
            XCTAssertEqual(result, compareResult, "Fail")
        }
    }
    
    func testSplitMessageSuccessCaseSuccess30characters() {
        let message = "123456789_123456789_123456789"
        let result = composingModelTest.split(message: message)
        let compareResult = ["123456789_123456789_123456789"]
        for text in result {
            print(text)
            XCTAssertEqual(result, compareResult, "Fail")
        }
    }
    
    func testSplitMessageSuccessCaseSuccess50characters() {
        let message = "123456789_123456789_123456789_123456789_123456789_"
        let result = composingModelTest.split(message: message)
        let compareResult = ["123456789_123456789_123456789_123456789_123456789_"]
        for text in result {
            print(text)
            XCTAssertEqual(result, compareResult, "Fail")
        }
    }
    
    func testSplitMessageSuccessCaseSuccess51characters() {
        let message = "123456789_123456789_123456789 123456789_123456789_"
        let result = composingModelTest.split(message: message)
        let compareResult = ["1/2 123456789_123456789_123456789",
                             "2/2 123456789_123456789_"]
        for text in result {
            print(text)
            XCTAssertEqual(result, compareResult, "Fail")
        }
    }
    
    func testSplitMessageSuccessCaseSuccess93characters() {
        let message = "123456789_123456789_123456789_123456789_123456 123456789-123456789-123456789-123456789-12345"
        let result = composingModelTest.split(message: message)
        let compareResult = ["1/2 123456789_123456789_123456789_123456789_123456",
                             "2/2 123456789-123456789-123456789-123456789-12345"]
        for text in result {
            print(text)
            XCTAssertEqual(result, compareResult, "Fail")
        }
    }
    
    func testSplitMessageSuccessCaseSuccess422characters() {
        let message = "123456789_123456789_123456789_123456789_123456 123456789_123456789_123456789_123456789_123456 123456789_123456789_123456789_123456789_123456 123456789_123456789_123456789_123456789_123456 123456789_123456789_123456789_123456789_123456 123456789_123456789_123456789_123456789_123456 123456789_123456789_123456789_123456789_123456 123456789_123456789_123456789_123456789_123456 123456789_123456789_123456789_123456789_123456"
        let result = composingModelTest.split(message: message)
        let compareResult:[String] = ["1/9 123456789_123456789_123456789_123456789_123456",
                                      "2/9 123456789_123456789_123456789_123456789_123456",
                                      "3/9 123456789_123456789_123456789_123456789_123456",
                                      "4/9 123456789_123456789_123456789_123456789_123456",
                                      "5/9 123456789_123456789_123456789_123456789_123456",
                                      "6/9 123456789_123456789_123456789_123456789_123456",
                                      "7/9 123456789_123456789_123456789_123456789_123456",
                                      "8/9 123456789_123456789_123456789_123456789_123456",
                                      "9/9 123456789_123456789_123456789_123456789_123456"]
        for text in result {
            print(text)
            XCTAssertEqual(result, compareResult, "Fail")
        }
    }
    
    func testSplitMessageSuccessCaseSuccess423characters() {
        let message = "123456789_123456789_123456789_123456789_123456 123456789_123456789_123456789_123456789_123456 123456789_123456789_123456789_123456789_123456 123456789_123456789_123456789_123456789_123456 123456789_123456789_123456789_123456789_123456 123456789_123456789_123456789_123456789_123456 123456789_123456789_123456789_123456789_123456 123456789_123456789_123456789_123456789_123456 123456789_123456789_123456789_123456789_123456 "
        let result = composingModelTest.split(message: message)
        let compareResult:[String] = []
        for text in result {
            print(text)
            XCTAssertEqual(result, compareResult, "Fail")
        }
    }
    
    func testSplitMessageSuccessCaseError51characters() {
        let message = "123456789_123456789_123456789_123456789_123456789_1"
        let result = composingModelTest.split(message: message)
        let compareResult:[String] = []
        for text in result {
            print(text)
            XCTAssertEqual(result, compareResult, "Fail")
        }
    }
    
    func testSplitMessageSuccessCaseError94characters() {
        let message = "123456789_123456789_123456789_123456789_123456 123456789-123456789-123456789-123456789-12345678"
        let result = composingModelTest.split(message: message)
        let compareResult:[String] = []
        for text in result {
            print(text)
            XCTAssertEqual(result, compareResult, "Fail")
        }
    }
    
//    func testSplitMessageSuccessCaseError4464characters() {
//        var message_ = "123456789_123456789 123456789_123456789_123 "
//        for _ in 1...100 { message = message + message_ }
//        message = message + " 123456789_123456789_123456789 123456789_123456789_123456789_123"
//        let result = composingModelTest.split(message: message)
//        let compareResult:[String] = []
//        for text in result {
//            print(text)
//            XCTAssertEqual(result, compareResult, "Fail")
//        }
//    }
    
    
    
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
//            testSplitMessageSuccessCaseError51characters()
        }
    }
    
}
