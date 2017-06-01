//
//  ViewController.swift
//  POLC
//
//  Created by Manikanta Nallabelly on 5/31/17.
//  Copyright © 2017 Manikanta Nallabelly. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var matrix = Matrix([3, 4, 1, 2, 8, 6, 6, 1, 8, 2, 7, 4, 5, 9, 3, 9, 9, 5, 8, 4, 1, 3, 2, 6, 3, 7, 2, 8, 6, 4], rows:5, columns:6)
        findPathOf(matrix: matrix)

        matrix = Matrix([3, 4, 1, 2, 8, 6, 6, 1, 8, 2, 7, 4, 5, 9, 3, 9, 9, 5, 8, 4, 1, 3, 2, 6, 3, 7, 2, 1, 2, 3], rows:5, columns:6)
        findPathOf(matrix: matrix)

        matrix = Matrix([19, 10, 19, 10, 19, 21, 23, 20, 19, 12, 20, 12, 20, 11, 10], rows:3, columns:5)
        findPathOf(matrix: matrix)
        
        matrix = Matrix([5, 8, 5, 3, 5], rows:1, columns:5)
        findPathOf(matrix: matrix)

        matrix = Matrix([5, 8, 5, 3, 5], rows:5, columns:1)
        findPathOf(matrix: matrix)

        matrix = Matrix<Int>([], rows:0, columns:0)
        findPathOf(matrix: matrix)

        matrix = Matrix([69, 10, 19, 10, 19, 51, 23, 20, 19, 12, 60, 12, 20, 11, 10], rows:3, columns:5)
        findPathOf(matrix: matrix)

        matrix = Matrix([60, 3, 3, 6, 6, 3, 7, 9, 5, 6, 8, 3], rows:3, columns:4)
        findPathOf(matrix: matrix)

        matrix = Matrix([6, 3, -5, 9, -5, 2, 4, 10, 3, -2, 6, 10, 6, -1, -2, 10], rows:4, columns:4)
        findPathOf(matrix: matrix)

        matrix = Matrix([51, 51, 0, 51, 51, 51, 5, 5], rows:4, columns:2)
        findPathOf(matrix: matrix)

        matrix = Matrix([51, 51, 51, 0, 51, 51, 51, 51, 51, 5, 5, 51], rows:4, columns:3)
        findPathOf(matrix: matrix)

        matrix = Matrix([1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], rows:1, columns:20)
        findPathOf(matrix: matrix)
    }
    
/**
     Checks for the path status and prints the output in the specifed format
*/
    func findPathOf(matrix:Matrix<Int>?) {
        let polc = PathOfLeastCost()
        let pathStatus:PathStatus = polc.calculateLeastPath(on: matrix)
        
        switch pathStatus {
        case .invalidData:
            print("Invalid matrix")
        case .pathFound(let cost, let path):
            print("YES\n\(cost)\n\(path)")
        case .pathNotFound(let cost, let path):
            print("NO\n\(cost)\n\(path)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

