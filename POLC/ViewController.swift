//
//  ViewController.swift
//  POLC
//
//  Created by Manikanta Nallabelly on 5/31/17.
//  Copyright © 2017 Manikanta Nallabelly. All rights reserved.
//

import UIKit

extension String {
    
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
}

class ViewController: UIViewController {
    @IBOutlet weak private var textViewMatrixInput:UITextView!
    @IBOutlet weak private var lblPathOutput:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func clickedGetPathBtn(sender: UIButton) {
        // Parse the input matrix
        guard let matrix = parseMatrixInput() else {
            lblPathOutput.text = "Invalid matrix\n"
            return
        }
        
        // The matrix is valid, get the least path
        findPathOf(matrix: matrix)
    }
    
/**     Parses the string entered in the textView and converts the same if valid into an instance of Matrix
            Returns - (Matrix) If success it will return the number otherwise it nil
*/
    func parseMatrixInput() -> Matrix<Int>? {
        // Separate the given string with whitespace separator
        let inputTexts = textViewMatrixInput.text.components(separatedBy: .whitespaces)
        
        var prevColumnCounter = 0
        var columnCounter = 0
        var rowCounter = 1
        var inputNumbers = Array<Int>()
        
        // Go through the strings
        for i in 0..<inputTexts.count {
            let inputText = inputTexts[i]
            
            // Sometimes I get empty strings, filtering them out
            if (inputText == "") {
                continue
            }
            
            // Separate the given string with newline separator
            let newLineStrings = inputText.components(separatedBy: .newlines)

            // Handle strings with newlines
            if newLineStrings.count > 1 {
                // Sometimes I get empty strings, filtering them out
                if (newLineStrings[0] != "") {
                    let (isValid, number) = isValidInteger(string: newLineStrings[0])
                    if isValid == false {
                        return nil
                    }
                    inputNumbers.append(number)
                    columnCounter = columnCounter + 1
                    
                    if (prevColumnCounter != 0 && prevColumnCounter != columnCounter) {
                        return nil
                    }
                    prevColumnCounter = columnCounter
                }
                
                // Sometimes I get empty strings, filtering them out
                if newLineStrings[1] != "" {
                    rowCounter = rowCounter + 1
                    let (isNumValid, num) = isValidInteger(string: newLineStrings[1])
                    if isNumValid == false {
                        return nil
                    }
                    inputNumbers.append(num)
                    columnCounter = 1
                }
            }
            else {
                let (isValid, number) = isValidInteger(string: inputText)
                if isValid == false {
                    return nil
                }
                inputNumbers.append(number)
                columnCounter = columnCounter + 1
            }
        }
        return Matrix<Int>(inputNumbers, rows: rowCounter, columns: columnCounter)
    }
    
/** Checks whether the input string can be converted to integer
        Returns - (Bool, Int) If success it will return the number otherwise it returns (false, -1)
 */
    func isValidInteger(string:String) -> (Bool, Int) {
        var isValid:Bool = false
        if let number =  Int(string) {
            isValid = true
            return (isValid, number)
        }
        
        return (isValid, -1)
    }
    
/**
     Checks for the path status and prints the output in the specifed format
*/
    func findPathOf(matrix:Matrix<Int>?) {
        let polc = PathOfLeastCost()
        let pathStatus:PathStatus = polc.calculateLeastPath(on: matrix)
        
        switch pathStatus {
        case .invalidData:
            lblPathOutput.text = "Invalid matrix\n"
        case .pathFound(let cost, let path):
            lblPathOutput.text = "YES\n\(cost)\n\(path)"
        case .pathNotFound(let cost, let path):
            lblPathOutput.text = "NO\n\(cost)\n\(path)"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}

