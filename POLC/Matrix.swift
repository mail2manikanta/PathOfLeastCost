//
//  Matrix.swift
//  POLC
//
//  Created by Manikanta Nallabelly on 5/31/17.
//  Copyright © 2017 Manikanta Nallabelly. All rights reserved.
//

import Foundation

class Matrix<T> {
    
    private var data:Array<T>
    
    var rows: Int
    var columns: Int
    
    init?(_ data:Array<T>, rows:Int, columns:Int) {
        
        if data.count != rows*columns {
            return nil
        }
        
        self.data = data
        self.rows = rows
        self.columns = columns
    }

    subscript(row: Int, col: Int) -> T {
        get {
            return data[(row * columns) + col]
        }
        
        set {
            self.data[(row * columns) + col] = newValue
        }
    }
    
    func col(index:Int) -> [T] {
        var c = [T]()
        for row in 0..<rows {
            c.append(self[row,index])
        }
        return c
    }
}


extension Matrix: CustomStringConvertible {
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
