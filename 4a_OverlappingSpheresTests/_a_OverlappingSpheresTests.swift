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
    
   /* func testCartesianToSpherical() {
        let model = MonteCarloWaves(withData: false)
        
        let sphere = MonteCarloWaves(withData: true).cartesianToSpherical(x: 5.0, y: -7.0, z: 7.0, xOffSet: 0.0, yOffSet: 0.0, zOffSet: 0.0)
        
        XCTAssertEqual(sphere.r, 11.090536506409418, accuracy: 1.0E-4, "Was not equal to this resolution.")
        XCTAssertEqual(sphere.theta, 0.8877372352984988, accuracy: 1.0E-4, "Was not equal to this resolution.")
        XCTAssertEqual(sphere.phi, -0.9505, accuracy: 1.0E-4, "Was not equal to this resolution.")
        
    }*/
    
    func test1sOrb() {
        
        let model = MonteCarloWaves()
        
        let a = 0.529177210903
        var r = 0.0
        
        var result = MonteCarloWaves().orbital1s(a: a, r: r)
        var actual = (1/sqrt(Double.pi)) * pow(1/a, Double(3/2)) * exp(-r/a)
        print(result, actual)
        XCTAssertEqual(result, actual, accuracy: 1.0E-7, "Was not equal to this resolution.")
        
        r = 0.5
        result = MonteCarloWaves().orbital1s(a: a, r: r)
        actual = (1/sqrt(Double.pi)) * pow(1/a, Double(3/2)) * exp(-r/a)
        print(result, actual)
        XCTAssertEqual(result, actual, accuracy: 1.0E-7, "Was not equal to this resolution.")
        
        r = 11.49571
        result = MonteCarloWaves().orbital1s(a: a, r: r)
        actual = (1/sqrt(Double.pi)) * pow(a, Double(-3.0/2)) * exp(-r/a)
        print(result, actual)
        XCTAssertEqual(result, actual, accuracy: 1.0E-12, "Was not equal to this resolution.")
        
        let my = MonteCarloWaves().cartesianToSpherical(x: -9.3355, y: -6.151384, z: 2.675792, xOffSet: 0, yOffSet: 0, zOffSet: 0)
        print(my.r, my.phi, my.theta)
        
    }
    
    

}
