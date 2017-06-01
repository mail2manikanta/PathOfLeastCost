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
        
        let matrix = Matrix([51, 51, 51, 0, 51, 51, 51, 51, 51, 5, 5, 51], rows:4, columns:3)
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

