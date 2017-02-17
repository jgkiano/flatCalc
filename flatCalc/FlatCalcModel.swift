//
//  FlatCalcModel.swift
//  flatCalc
//
//  Created by Julius Kiano on 2/15/17.
//  Copyright © 2017 Julius Kiano. All rights reserved.
//

import UIKit


class FlatCalcModel: NSObject {
    
    //list of operations
    let operations:[String:String] = [
        "divide":"/",
        "multiply":"x",
        "subtract":"-",
        "add":"+",
        "equals":"=",
        "clear":"C"
    ]
    
    // mathematical constants
    let constants: [String:Double] = [
        "π": Double.pi,
        "e": M_E
    ]
    
    // mathematical functions
    let mathFunctions: [String:String] = [
        "squareRoot": "√",
        "cubeRoot": "∛",
        "powerTwo": "^2",
        "log": "log"
    ]
    
    //leftNumber -- like your accumulator, sort of maybe
    var leftNum: Double? = nil
    
    //current operation being performed
    var currentOp: String? = nil
    
    //set usertyping as false
    var userTyping = false
    
    //has user explicitly pressed
    var hasPressedEquals = false
    
    //keep track of decimals
    var decimalCount = 0
    
    //assignment variable
    var isPartialResult: Bool = true
    
    //are we currenly performing a math function
    var isPerformingMathFunc: Bool = false
    
    var labelNumber :Double = 0
    
    var labelHistory = ""
    
    var result: Double {
        get{
            return labelNumber
        }
    }
    
    var history: String {
        get{
            return labelHistory
        }
    }
    
    public func performOperation(s: String, o: String) {
        labelNumber = Double(s)!
        if o == operations["add"] {
            performOpCheckForCurrentOp(mathOp: "add")
        }
        if o == operations["subtract"] {
            performOpCheckForCurrentOp(mathOp: "subtract")
        }
        if o == operations["multiply"] {
            performOpCheckForCurrentOp(mathOp: "multiply")
        }
        if o == operations["divide"] {
            performOpCheckForCurrentOp(mathOp: "divide")
        }
        if o == operations["clear"] {
            clearEverything()
            labelNumber = 0
        }
        if o == operations["equals"] {
            performEquals()
        }
    }
    
    public func getConstant(s: String) {
        labelNumber = constants[s]!
    }
    
    public func performMathFunc(s: String) {
        if currentOp != nil {
            labelNumber = performPendingOp()
        }
        clearEverything()
        let currentFunc = s
        isPerformingMathFunc = true
        if(currentFunc == mathFunctions["squareRoot"]) {
            labelHistory = mathFunctions["squareRoot"]!
            currentOp = "squareRoot"
        }
        if(currentFunc == mathFunctions["cubeRoot"]) {
            labelHistory = mathFunctions["cubeRoot"]!
            currentOp = "cubeRoot"
        }
        if(currentFunc == mathFunctions["powerTwo"]) {
            labelHistory = mathFunctions["powerTwo"]!
            currentOp = "powerTwo"
        }
        if(currentFunc == mathFunctions["log"]) {
            labelHistory = mathFunctions["log"]!
            currentOp = "log"
        }
    }
    
    func performOpCheckForCurrentOp(mathOp :String) {
        if currentOp != nil && isPerformingMathFunc == true {
            let result: Double = performPendingOp()
            labelNumber = result
            setUpLeftNumAndOp(currOp: mathOp)
        } else {
            setUpLeftNumAndOp(currOp: mathOp)
        }
    }
    
    func setUpLeftNumAndOp(currOp :String) {
        if hasPressedEquals {
            labelHistory = ""
            hasPressedEquals = false
        }
        //////check this out////////
        if (isPerformingMathFunc) {
            
        }
        buildHistory(o: operations[currOp]!)
        if(leftNum == nil) {
            leftNum = labelNumber
            print("here")
        } else if currentOp != nil {
            leftNum = performPendingOp()
            labelNumber = leftNum!
        }
        currentOp = currOp
    }
    
    func buildHistory(o:String) {
        let num = labelNumber .truncatingRemainder(dividingBy: 1)  == 0 ? String(format: "%.0f", labelNumber) : String(labelNumber)
        labelHistory = labelHistory + "\(num) \(o) "
    }
    
    
    func performEquals() {
        labelHistory = ""
        leftNum = performPendingOp()
        labelNumber = leftNum!
        buildHistory(o: "")
        currentOp = nil
        hasPressedEquals = true
    }
    
    
    func clearEverything() {
        leftNum = nil
        currentOp = nil
        userTyping = false
        labelHistory = ""
        currentOp = nil
        isPerformingMathFunc = false
    }
    
    
    func performPendingOp() -> Double {
        if currentOp == "add" {
            return leftNum! + labelNumber
        }
        if currentOp == "subtract" {
            return leftNum! - labelNumber
        }
        if currentOp == "multiply" {
            return leftNum! * labelNumber
        }
        if currentOp == "divide" {
            return leftNum! / labelNumber
        }
        if currentOp == "squareRoot" {
            currentOp = nil
            return sqrt(labelNumber)
        }
        if currentOp == "cubeRoot" {
            currentOp = nil
            return cbrt(labelNumber)
        }
        if currentOp == "powerTwo" {
            currentOp = nil
            return pow(labelNumber, 2)
        }
        if currentOp == "log" {
            currentOp = nil
            return log(labelNumber)
        }
        return 0
    }

}
