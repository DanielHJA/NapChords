//
//  NapChordsTests.swift
//  NapChordsTests
//
//  Created by Daniel Hjärtström on 2018-06-09.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import XCTest
@testable import NapChords

class NapChordsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testThatRESTReturnsFailureWhenNoResults() {
        let ex = expectation(description: "Expect failure to be .noResults")
        
        WebService.fetchChords(query: "ll.l.l.l.l.l.l.l.l", completion: { (object) in
        }) { (error) in
            ex.fulfill()
            XCTAssertTrue(error.description == CustomError.noResults.description)
        }
        
        waitForExpectations(timeout: 10.0, handler: { (error) in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
            }
        })
    }
    
    func testThatRESTReturnsData() {
        let ex = expectation(description: "Expect object to not be nil")
        
        WebService.fetchChords(query: "Eminem", completion: { (object) in
            XCTAssertFalse(object.isEmpty)
            ex.fulfill()
        }) { (error) in
                XCTFail("Error: \(error.description)")
        }
        
        waitForExpectations(timeout: 10.0, handler: { (error) in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
            }
        })
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
