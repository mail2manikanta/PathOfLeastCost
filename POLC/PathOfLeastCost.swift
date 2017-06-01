//
//  PathOfLeastCost.swift
//  POLC
//
//  Created by Manikanta Nallabelly on 5/31/17.
//  Copyright © 2017 Manikanta Nallabelly. All rights reserved.
//

import Foundation

/**
    This represents the status of the least cost path.
 
    - pathFound(cost, path): Valid low cost complete path exists.
                cost - represents the minimum cost to traverse the path
                path -  represents the sequence of row numbers
    - pathNotFound(cost, path): There is no valid path whose cost is within the maximum specified.
                cost - The cost of the incomplete path until the maximum allowed
                path - The sequence of row numbers of the incomplete path
    - invalidData: No Path, invalid data
 */

enum PathStatus {
    case pathFound(Int, String)
    case pathNotFound(Int, String)
    case invalidData
}

/// Equitable extension to be able to compare any two instances of the enum PathStatus
extension PathStatus: Equatable {
    static func ==(lhs: PathStatus, rhs: PathStatus) -> Bool {
        switch (lhs, rhs) {
        case (let .pathFound(cost1, path1), let .pathFound(cost2, path2)):
            return cost1 == cost2 && path1 == path2
            
        case (let .pathNotFound(cost1, path1), let .pathNotFound(cost2, path2)):
            return cost1 == cost2 && path1 == path2
            
        case (.invalidData, .invalidData):
            return true
            
        default:
            return false
        }
    }
}

/// All the logic related to calculating the least path is represented in this class
class PathOfLeastCost {
    /// The threshold value representing the cost for any path
    static let maxCost:Int = 50
    
    /**
     This calculates the least cost path on a given Matrix
     
     - Parameter matrix:  A valid intance of Matrix which holds all values as integers
     
     - Returns: This returns one of the below states representing PathStatus.
    
                1. pathFound(cost, path) - A valid complete path within the specified threshold is found
                2. pathNotFound(cost, path) - An incomplete path with cost value not exceeding the threshold
                3. invalidData - The input matrix is either invalid or nil
     */
    func calculateLeastPath(on matrix:Matrix<Int>?) -> PathStatus {
        // Check for null matrix
        guard let matrix = matrix else {
            return .invalidData
        }
        
        let rows = matrix.rows
        let columns = matrix.columns
        
        // Check for empty rows or columns in the given matrix
        if (rows == 0 || columns == 0) {
            return .invalidData
        }
        
        /** The costMatrix represents the cost to reach any particular element in the given matrix
            Initialize the costMatrix with zero values
        */
        guard var costMatrix = Matrix<Int>(Array(repeatElement(0, count: rows*columns)), rows: rows, columns: columns) else {
            return .invalidData
        }
        
        /** The pathMatrix represents the path to reach any particular element in the given matrix
         Initialize the pathMatrix with empty strings
         For example to represent the path [1 2 4], it stores the elements with space separated as "1 2 4"
         */
        guard var pathMatrix = Matrix<String>(Array(repeatElement("", count: rows*columns)), rows: rows, columns: columns) else {
            return .invalidData
        }
        
        // The cost and path matrices are initialized for the first column with the value from the given input matrix and the row number at the corresponding position respectively
        initializeFirstColumn(costMatrix: &costMatrix, pathMatrix: &pathMatrix, with:matrix)
 
        // Iterating through all the elements
        columnLoop:for column in 1..<columns {
            rowLoop:for row in 0..<rows {
                // Find the cost and path to reach the column preceding the element at the given row and column position
                let (cost, path) = minCostAndPath(of: costMatrix, at: row, and: column)
                
                // The cost to reach the element(row, column) is the cost of the element itself and the cost preceding it
                costMatrix[row, column] = cost + matrix[row, column]
                
                // Appending the current row position (1 to totalRows) to the path of the preceding column in the pathMatrix
                pathMatrix[row, column] = String("\(pathMatrix[path, column - 1]) \(row + 1)")
            }
        }
        return checkForPathValidityFrom(costMatrix: costMatrix, pathMatrix: pathMatrix)
    }
    
/** 
     The cost and path matrices are initialized for the first column with the value from the given input matrix and the row number at the corresponding position respectively
*/
    private func initializeFirstColumn(costMatrix:inout Matrix<Int>, pathMatrix:inout Matrix<String>, with matrix:Matrix<Int>) {
        let rows = matrix.rows
        for row in 0..<rows {
            costMatrix[row, 0] = matrix[row, 0]
            // Incremented 1 so that path representing the rowNumber starts from 1 to numberOfRows
            pathMatrix[row, 0] = String("\(row + 1)")
        }
    }
    
/**
     Evaluates whether the paths calculated are within the threshold cost value
     
     - Returns: This returns one of the below states representing PathStatus.
        1. pathFound(cost, path) - A valid complete path within the specified threshold is found
        2. pathNotFound(cost, path) - An incomplete path with cost value not exceeding the threshold
        3. invalidData - The input matrix is either invalid or nil
*/
    private func checkForPathValidityFrom(costMatrix:Matrix<Int>, pathMatrix:Matrix<String>) -> PathStatus {
        
        var pathCost:PathStatus = .invalidData
        
        let columns = costMatrix.columns
        var currentColumn = columns - 1
        
        //Iterating through columns starting from the last one to check for complete path
        while (currentColumn >= 0) {
            let currentColumnCosts = costMatrix.col(index: currentColumn)
            let currentColumnLeastCost = currentColumnCosts.reduce(Int.max, { min($0, $1) })
            
            // Check whether the cost is within the maximum specified
            if (currentColumnLeastCost < PathOfLeastCost.maxCost) {
                guard let leastCostIndex = currentColumnCosts.index(of: currentColumnLeastCost) else {
                    //Something wrong !!???
                    break
                }
                
                let leastCost = currentColumnLeastCost
                let leastCostPath = "[\(pathMatrix[leastCostIndex, currentColumn])]"
                
                if currentColumn == columns - 1 {
                    // Found a complete path
                    pathCost = .pathFound(leastCost, leastCostPath)
                }
                else {
                    // The path is incomplete
                    pathCost = .pathNotFound(leastCost, leastCostPath)
                }
                break
            }
            
            // Iterated all columns and unable to find the path within the maximum specified
            if currentColumn == 0 && currentColumnLeastCost > PathOfLeastCost.maxCost {
                pathCost = .pathNotFound(0, "[]")
            }
            
            currentColumn = currentColumn - 1
        }
        return pathCost
    }
    
// Find the cost and path to reach the column preceding the element at the given row and column position
    private func minCostAndPath(of costMatrix:Matrix<Int>, at row:Int, and column:Int) -> (Int, Int) {
        let currentRow = row
        
        // Previous row will be the last row if the current is the first one
        let previousRow = row == 0 ? costMatrix.rows - 1 : row - 1
        
        // Next row will be the first row if the current is the last one
        let nextRow = row == costMatrix.rows - 1 ? 0 : row + 1
        
        let currentRowElement = costMatrix[currentRow, column - 1]
        let previousRowElemnt = costMatrix[previousRow, column - 1]
        let nextRowElement = costMatrix[nextRow, column - 1]
        
        // The minimum cost to reach a particular element is the minimum value of the (previousRow, currentRow, nextRow) in the preceding column
        
        if (previousRowElemnt < currentRowElement) {
            return previousRowElemnt < nextRowElement ? (previousRowElemnt, previousRow) : (nextRowElement, nextRow)
        }
        else {
            return currentRowElement < nextRowElement ? (currentRowElement, currentRow) : (nextRowElement, nextRow)
        }
    }
    
 
}
