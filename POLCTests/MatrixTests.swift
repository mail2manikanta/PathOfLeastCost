//
//  MatrixTests.swift
//  POLC
//
//  Created by Manikanta Nallabelly on 5/31/17.
//  Copyright © 2017 Manikanta Nallabelly. All rights reserved.
//

import XCTest
@testable import POLC

class MatrixTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMatrixWithInvalidData() {
        let matrix:Matrix<Int>? = Matrix([1, 2, 3, 4, 8, 2, 1, 5, 3], rows:5, columns:10)
        XCTAssert(matrix == nil, "Invalid rows and columns count")
    }
    
    func testMatrixWithNegativeRowsAndColumns() {
        let matrix:Matrix<Int>? = Matrix([1, 2, 3, 4, 8, 2, 1, 5, 3], rows:-3, columns:-3)
        XCTAssert(matrix == nil, "Invalid rows and columns count")
    }

    
    func testMatrixWithValidData() {
        let matrix:Matrix<Int>? = Matrix([1, 2, 3, 4, 8, 2, 1, 5, 3], rows:3, columns:3)
        XCTAssert(matrix != nil, "Valid rows and columns count")
    }
    
    func testMatrixSubScriptGetter() {
        guard let matrix:Matrix<Int> = Matrix([1, 2, 6, 4, 22, 2], rows:2, columns:3) else {
            XCTAssert(false, "Invalid matrix")
            return
        }
        
        XCTAssert(matrix[1, 2] == 2, "Unable to read the proper value at given position")
    }
    
    func testMatrixSubScriptSetter() {
        guard let matrix:Matrix<Int> = Matrix([0, 9, 6, 7, 22, 2], rows:2, columns:3) else {
            XCTAssert(false, "Invalid matrix")
            return
        }
        matrix[1, 2] = 10
        XCTAssert(matrix[1, 2] == 10, "Unable to read the value which was set at given position")
    }
}
