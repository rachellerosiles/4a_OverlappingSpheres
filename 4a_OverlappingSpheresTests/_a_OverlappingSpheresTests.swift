//
//  _a_OverlappingSpheresTests.swift
//  4a_OverlappingSpheresTests
//
//  Created by PHYS 440 Rachelle on 2/16/24.
//

import XCTest
import Foundation
import SwiftUI

final class _a_OverlappingSpheresTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testCartesianToSpherical() async {
        let model = MonteCarlo()
        
        let sphere = await MonteCarlo().cartesianToSpherical(x: 1.0, y: 1.0, z: 1.0, xOffSet: 0.0, yOffSet: 0.0, zOffSet: 0.0)
        
        XCTAssertEqual(sphere.r, 1.0, accuracy: 1.0E-7, "Was not equal to this resolution.")
        XCTAssertEqual(sphere.theta, 45.0, accuracy: 1.0E-7, "Was not equal to this resolution.")
        
    }

}
