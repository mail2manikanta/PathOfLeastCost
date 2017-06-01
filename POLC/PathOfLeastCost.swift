//
//  PathOfLeastCost.swift
//  POLC
//
//  Created by Manikanta Nallabelly on 5/31/17.
//  Copyright © 2017 Manikanta Nallabelly. All rights reserved.
//

import Foundation


enum PathStatus {
    case pathFound(Int, String)
    case pathNotFound(Int, String)
    case invalidData
}

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

class PathOfLeastCost {
    static let maxCost:Int = 50
    
    func calculateLeastPath(on matrix:Matrix<Int>?) -> PathStatus {
        
        guard let matrix = matrix else {
            return .invalidData
        }
        
        let rows = matrix.rows
        let columns = matrix.columns
        
        if (rows == 0 || columns == 0) {
            return .invalidData
        }
        
        guard var costMatrix = Matrix<Int>(Array(repeatElement(0, count: rows*columns)), rows: rows, columns: columns) else {
            return .invalidData
        }
        
        guard var pathMatrix = Matrix<String>(Array(repeatElement("", count: rows*columns)), rows: rows, columns: columns) else {
            return .invalidData
        }
        
        initialize(costMatrix: &costMatrix, pathMatrix: &pathMatrix, with:matrix)
 
        columnLoop:for column in 1..<columns {
            rowLoop:for row in 0..<rows {
                let (cost, path) = minCostAndPath(of: costMatrix, at: row, and: column)
                costMatrix[row, column] = cost + matrix[row, column]
                pathMatrix[row, column] = String("\(pathMatrix[path, column-1]) \(row+1)")
            }
        }
        return findLeastCostAndPathFrom(costMatrix: costMatrix, pathMatrix: pathMatrix)
    }
    
    private func initialize(costMatrix:inout Matrix<Int>, pathMatrix:inout Matrix<String>, with matrix:Matrix<Int>) {
        let rows = matrix.rows
        for row in 0..<rows {
            costMatrix[row, 0] = matrix[row, 0]
            pathMatrix[row, 0] = String("\(row + 1)")
        }
    }
    
    private func findLeastCostAndPathFrom(costMatrix:Matrix<Int>, pathMatrix:Matrix<String>) -> PathStatus {
        
        var pathCost:PathStatus = .invalidData
        
        let columns = costMatrix.columns
        var currentColumn = columns-1
        while (currentColumn >= 0) {
            let currentColumnCosts = costMatrix.col(index: currentColumn)
            let currentColumnLeastCost = currentColumnCosts.reduce(Int.max, { min($0, $1) })
            
            if (currentColumnLeastCost < PathOfLeastCost.maxCost) {
                guard let leastCostIndex = currentColumnCosts.index(of: currentColumnLeastCost) else {
                    //Something wrong !!???
                    break
                }
                
                let leastCost = currentColumnLeastCost
                let leastCostPath = "[\(pathMatrix[leastCostIndex, currentColumn])]"
                
                if currentColumn == columns-1 {
                    pathCost = .pathFound(leastCost, leastCostPath)
                }
                else {
                    pathCost = .pathNotFound(leastCost, leastCostPath)
                }
                break
            }
            
            //Boundary condition
            if currentColumn == 0 && currentColumnLeastCost > PathOfLeastCost.maxCost {
                pathCost = .pathNotFound(0, "[]")
            }
            
            currentColumn = currentColumn-1
        }
        return pathCost
    }
    
    private func minCostAndPath(of costMatrix:Matrix<Int>, at row:Int, and column:Int) -> (Int, Int) {
        let currentRow = row
        let previousRow = row == 0 ? costMatrix.rows-1 : row-1
        let nextRow = row == costMatrix.rows-1 ? 0 : row+1
        
        let currentRowElement = costMatrix[currentRow, column-1]
        let previousRowElemnt = costMatrix[previousRow, column-1]
        let nextRowElement = costMatrix[nextRow, column-1]
        
        if (previousRowElemnt < currentRowElement) {
            return previousRowElemnt < nextRowElement ? (previousRowElemnt, previousRow) : (nextRowElement, nextRow)
        }
        else {
            return currentRowElement < nextRowElement ? (currentRowElement, currentRow) : (nextRowElement, nextRow)
        }
    }
    
 
}
