//
//  Matrix.swift
//  POLC
//
//  Created by Manikanta Nallabelly on 5/31/17.
//  Copyright © 2017 Manikanta Nallabelly. All rights reserved.
//

import Foundation

/**
    This class represents the data in matrix format.
    It takes an array of values of any type to construct the matrix.
 
    For example, to construct below matrix the input data is to be given as follows
 
    4 3 6
                -> [4 3 6 0 2 9]
    0 2 9
 */

class Matrix<T> {
    
    /// The data array of any single type which Matrix class internally uses to store
    private var data:Array<T>
    
    /// Represents the number of rows in the matrix
    var rows: Int
    
    /// Represents the number of columns in the matrix
    var columns: Int
    
    /**
     Initializes the matrix object
     
     - Parameter _:   Array of values of a single type
     - Parameter rows: The number of rows for the given data
     - Parameter columns: The number of columns for the given data
     
     - Returns: A new Matrix object, it may return nil if the count of the supplied array of data does not match with the given (rows * columns)
     */
    
    init?(_ data:Array<T>, rows:Int, columns:Int) {
        
        if (rows <= 0 || columns <= 0) {
            return nil
        }
        
        if data.count != rows*columns {
            return nil
        }
        
        self.data = data
        self.rows = rows
        self.columns = columns
    }

    /**
     The subscript accessor to read/set the values inside the matrix
     Usage: matrix[5,6] where matrix is an instance of Matrix class
     
     The row and column should be in the valid range the matrix holds, otherwise this call will cause exception

     - Parameter row:    The row position of the data
     - Parameter column: The column position of the data
     
     - Returns: The value at the given position in the matrix, The will cause exception if the specified range or column is out of bounds
     */

    subscript(row: Int, col: Int) -> T {
        get {
            return data[(row * columns) + col]
        }
        
        set {
            self.data[(row * columns) + col] = newValue
        }
    }
    
    /**
     This returns the values of the given column position in the given matrix as an array.
     If the colum position is out of range, this returns an empty array.
     
     - Parameter _:  The column position in the matrix
     
     - Returns: The array of values in the given column. This may return empty array for an invalid column number
     */
    
    func col(index:Int) -> [T] {
        var c = [T]()
        for row in 0..<rows {
            c.append(self[row,index])
        }
        return c
    }
}

extension Matrix: CustomStringConvertible {
    /**
     This returns the description of the given matrix in readable format.
     
     - Returns: The matrix of values in a readable format
     */

    var description: String {
        var dsc = ""
        for row in 0..<rows {
            for col in 0..<columns {
                let s = String(describing: self[row,col])
                dsc += s + " "
            }
            dsc += "\n"
        }
        return dsc
    }
}
