//
//  SpottyTests.swift
//  SpottyTests
//
//  Created by David Krystall on 2/11/17.
//  Copyright © 2017 David Krystall. All rights reserved.
//

import XCTest
@testable import Spotty

class SpottyTests: XCTestCase {
    let maxCalc = MaxCalculator()
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
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
    func testMaxUpperBodyCalculation(){
        let result = maxCalc.setWarningLbs(currWeight: 22.00, oneMaxRepLbs: 34.0, numOfReps: 4)
        print("Max rep is: \(result.description)")
        let shouldBeResult = "Safe Set"
        assert(shouldBeResult == result.description)
    }
    
}
