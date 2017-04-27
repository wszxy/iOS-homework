//
//  ViewController.swift
//  Calculator
//
//  Created by 唐成 on 17/04/2017.
//  Copyright © 2017 HUST. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTyping: Bool = false
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            let textCurrentInDisplay = display.text!
            display.text = textCurrentInDisplay + digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTyping = true
        }
    }
    
    var length: Int = 0
    
    var displayValue: Double { //calculated property
        get {
            if let value = display.text {
                let index = value.index(value.startIndex, offsetBy: length)
                let lastOperand = value.substring(from: index)
                if Double(lastOperand) == nil{
                    return 0.0001
                }
                return Double(lastOperand)!
            } else {
                userIsInTheMiddleOfTyping = false
                return 0
            }
        }
        set {
            display.text = String(newValue)
        }
    }
    
    private var brain = CalculatorBrain()
    
    
    @IBAction func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            if displayValue != 0.0001 {
                brain.setOperand(displayValue)
            }
            userIsInTheMiddleOfTyping = true
        }
        if let mathematicalSymbol = sender.currentTitle {
            let textCurrentInDisplay = display.text!
            display.text = textCurrentInDisplay + mathematicalSymbol
            brain.performOperation(mathematicalSymbol)
            length = (display.text!).characters.count
        }
//        if let result = brain.result {
//            displayValue = result
//        }
    }
    
    
    @IBAction func equal(_ sender: Any) {
        brain.equal()
        userIsInTheMiddleOfTyping = false
        if let result = brain.result {
            displayValue = result
        }
    }
    
    @IBAction func allClear(_ sender: Any) {
        userIsInTheMiddleOfTyping = false
        displayValue = 0
        brain.AC()
        length = 0
    }
}

