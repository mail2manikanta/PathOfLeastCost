//
//  POLCTests.swift
//  POLCTests
//
//  Created by Manikanta Nallabelly on 5/31/17.
//  Copyright © 2017 Manikanta Nallabelly. All rights reserved.
//

import XCTest
@testable import POLC

class POLCTests: XCTestCase {
    
    var pathOfLeastCost:PathOfLeastCost?
    
    override func setUp() {
        super.setUp()
        pathOfLeastCost = PathOfLeastCost()
    }
    
    override func tearDown() {
        pathOfLeastCost = nil
        super.tearDown()
    }
    
    func testPathForValidMatrix() {
        let matrix = Matrix([3, 4, 1, 2, 8, 6, 6, 1, 8, 2, 7, 4, 5, 9, 3, 9, 9, 5, 8, 4, 1, 3, 2, 6, 3, 7, 2, 8, 6, 4], rows:5, columns:6)
        let pathStatus = pathOfLeastCost?.calculateLeastPath(on: matrix)
        XCTAssert(pathStatus == PathStatus.pathFound(16, "[1 2 3 4 4 5]"), "Wrong Output")
    }
    
    func testMatrixWithMultiplePaths() {
         let matrix = Matrix([3, 4, 1, 2, 8, 6, 6, 1, 8, 2, 7, 4, 5, 9, 3, 9, 9, 5, 8, 4, 1, 3, 2, 6, 3, 7, 2, 1, 2, 3], rows:5, columns:6)
        let pathStatus = pathOfLeastCost?.calculateLeastPath(on: matrix)
        XCTAssert(pathStatus == PathStatus.pathFound(11, "[1 2 1 5 4 5]") || pathStatus == PathStatus.pathFound(11, "[1 2 1 5 5 5]"), "Wrong Output")
    }
    
    func testMatrixWithNoPath() {
        let matrix = Matrix([19, 10, 19, 10, 19, 21, 23, 20, 19, 12, 20, 12, 20, 11, 10], rows:3, columns:5)
        let pathStatus = pathOfLeastCost?.calculateLeastPath(on: matrix)
        XCTAssert(pathStatus == PathStatus.pathNotFound(48, "[1 1 1]"), "Wrong Output")
    }
 
    func testMatrixWithSingleRow() {
        let matrix = Matrix([5, 8, 5, 3, 5], rows:1, columns:5)
        let pathStatus = pathOfLeastCost?.calculateLeastPath(on: matrix)
        XCTAssert(pathStatus == PathStatus.pathFound(26, "[1 1 1 1 1]"), "Wrong Output")
    }

    func testMatrixWithSingleColumn() {
        let matrix = Matrix([5, 8, 5, 3, 5], rows:5, columns:1)
        let pathStatus = pathOfLeastCost?.calculateLeastPath(on: matrix)
        XCTAssert(pathStatus == PathStatus.pathFound(3, "[4]"), "Wrong Output")
    }
 
    func testEmptyMatrix() {
        let matrix = Matrix<Int>([], rows:0, columns:0)
        let pathStatus = pathOfLeastCost?.calculateLeastPath(on: matrix)
        XCTAssert(pathStatus == PathStatus.invalidData, "Wrong Output")
    }

    func testMatrixWithAllValuesExceedingMax() {
        let matrix = Matrix([69, 10, 19, 10, 19, 51, 23, 20, 19, 12, 60, 12, 20, 11, 10], rows:3, columns:5)
        let pathStatus = pathOfLeastCost?.calculateLeastPath(on: matrix)
        XCTAssert(pathStatus == PathStatus.pathNotFound(0, "[]"), "Wrong Output")
    }
    
    func testMatrixWithCostExceedingMax() {
        let matrix = Matrix([60, 3, 3, 6, 6, 3, 7, 9, 5, 6, 8, 3], rows:3, columns:4)
        let pathStatus = pathOfLeastCost?.calculateLeastPath(on: matrix)
        XCTAssert(pathStatus == PathStatus.pathFound(14, "[3 2 1 3]"), "Wrong Output")
    }


    func testMatrixWithNegativeValues() {
        let matrix = Matrix([6, 3, -5, 9, -5, 2, 4, 10, 3, -2, 6, 10, 6, -1, -2, 10], rows:4, columns:4)
        let pathStatus = pathOfLeastCost?.calculateLeastPath(on: matrix)
        XCTAssert(pathStatus == PathStatus.pathFound(0, "[2 3 4 1]"), "Wrong Output")
    }
    
    func testMatrixWithLowerCostIncompletePath() {
        let matrix = Matrix([51, 51, 0, 51, 51, 51, 5, 5], rows:4, columns:2)
        let pathStatus = pathOfLeastCost?.calculateLeastPath(on: matrix)
        XCTAssert(pathStatus == PathStatus.pathFound(10, "[4 4]"), "Wrong Output")
    }
    
    func testMatrixWithLongerIncompletePath() {
        let matrix = Matrix([51, 51, 51, 0, 51, 51, 51, 51, 51, 5, 5, 51], rows:4, columns:3)
        let pathStatus = pathOfLeastCost?.calculateLeastPath(on: matrix)
        XCTAssert(pathStatus == PathStatus.pathNotFound(10, "[4 4]"), "Wrong Output")
    }
    
    func testMatrixWithLargeColumns() {
        let matrix = Matrix([1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], rows:1, columns:20)
        let pathStatus = pathOfLeastCost?.calculateLeastPath(on: matrix)
        XCTAssert(pathStatus == PathStatus.pathFound(20, "[1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]"), "Wrong Output")
    }
}
