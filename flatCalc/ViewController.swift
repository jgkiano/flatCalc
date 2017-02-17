//
//  ViewController.swift
//  flatCalc
//
//  Created by Julius Kiano on 2/14/17.
//  Copyright © 2017 Julius Kiano. All rights reserved.
//

import UIKit

//all thanks to the overflow of stacks
extension Double {
    var cleanValue: String {
        return self .truncatingRemainder(dividingBy: 1)  == 0 ? String(format: "%.0f", self) : String(self)
    }
}

class ViewController: UIViewController {

    
    var model: FlatCalcModel = FlatCalcModel()
    
    var decimalCount = 0
    
    @IBOutlet weak var advancedOps: UIStackView!

    @IBOutlet weak var operationHistorylbl: UILabel!
    
    @IBOutlet weak var label: UILabel!
    
    var userTyping :Bool = false
    
    
    var displayValue: Double {
        get{
            return Double(label.text!)!
        }
        set{
            label.text = String(newValue.cleanValue)
        }
    }
    
    var historyValue: String {
        get{
            return operationHistorylbl.text!
        }
        set{
            operationHistorylbl.text = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set the initial 0
        label.text = "0"
        //hide alien controls
        advancedOps.isHidden = true
    }
    
    @IBAction func toggleBtn(_ sender: UIButton) {
        //here we just toggle alien controls
        if advancedOps.isHidden == true {
            advancedOps.isHidden = false
        } else {
            advancedOps.isHidden = true
        }
    }
    
    @IBAction func mathFuncBtn(_ sender: UIButton) {
        userTyping = false
        model.performMathFunc(s: sender.currentTitle!)
        getDisplayAndHistory()
    }
    
    
    
    
    @IBAction func constantBtnPressed(_ sender: UIButton) {
        model.getConstant(s: sender.currentTitle!)
        getDisplayAndHistory()
    }
    
    
    @IBAction func numberPressed(_ sender: UIButton) {
        
        if userTyping {
            if(sender.currentTitle! == "." && decimalCount < 1) {
                decimalCount += 1
                label.text = label.text! + sender.currentTitle!
            } else if (sender.currentTitle == "." && decimalCount > 0) {
                label.text = label.text!
            } else {
                label.text = label.text! + sender.currentTitle!
            }
            
        } else {
            if(sender.currentTitle! == "." && decimalCount < 1) {
                decimalCount += 1
            } else if (sender.currentTitle == "." && decimalCount > 0) {
                
            } else {
                label.text = sender.currentTitle
                userTyping = true
            }
        }
        
    }
    
    @IBAction func performOp(_ sender: UIButton) {
        if(sender.currentTitle != nil && label.text != nil) {
            model.performOperation(s: label.text!, o: sender.currentTitle!)
            userTyping = false
        }
        getDisplayAndHistory()
        resetDecimal()
    }
    
    func resetDecimal() {
        decimalCount = 0
    }
    
    func getDisplayAndHistory()  {
        displayValue = model.result
        historyValue = model.history
    }

}

