//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by 唐成 on 21/04/2017.
//  Copyright © 2017 HUST. All rights reserved.
//

import Foundation


struct CalculatorBrain {
    
    private var accumulator: Double?
    
//    private enum Operation {
//        case constant(Double)
//        case unaryOperation((Double) -> Double)
//        case binaryOperation((Double,Double) -> Double)
//        case equals
//    }
    
    private struct Stack<T> {
        fileprivate var array = [T]()
        
        public var isEmpty: Bool {
            return array.isEmpty
        }
        
        public var count: Int {
            return array.count
        }
        
        public mutating func push(_ element: T) {
            array.append(element)
        }
        
        public mutating func pop() -> T? {
            return array.popLast()
        }
        
        public func peek() -> T? {
            return array.last
        }
    }

    private var stack: Stack<Any> = Stack()
    private var stackSymbol: Stack<String> = Stack()
    private var stackReverse: Stack<Any> = Stack()
    
    
    private var operationsPriority : Dictionary<String,Int> = [
        "×" : 3,
        "÷" : 3,
        "+" : 2,
        "-" : 2,
        "(" : 1,
        ")" : 4

//        "=" : Operation.equals
    ]
    
    mutating func performOperation(_ symbol: String) {
        if stackSymbol.isEmpty {
            stackSymbol.push(symbol)
        }
        else if let prioity = operationsPriority[symbol] {
            switch prioity {
            case 1:
                stackSymbol.push(symbol)
            case 2:
                var temp: String = stackSymbol.peek()!
                while operationsPriority[temp]! >= 2 && !stackSymbol.isEmpty {
                    let popSymbol = stackSymbol.pop()
                    stack.push(popSymbol!)
                    if !stackSymbol.isEmpty{
                        temp = stackSymbol.peek()!
                    }
                }
                stackSymbol.push(symbol)
            case 3:
                var temp: String = stackSymbol.peek()!
                while operationsPriority[temp]! >= 3 && !stackSymbol.isEmpty{
                    let popSymbol = stackSymbol.pop()
                    stack.push(popSymbol!)
                    if !stackSymbol.isEmpty{
                        temp = stackSymbol.peek()!
                    }
                }
                stackSymbol.push(symbol)
            case 4:
                var peekValue: String = stackSymbol.peek()!
                while peekValue != "(" {
                    if let temp = stackSymbol.pop() {
                        stack.push(temp)
                        peekValue = stackSymbol.peek()!
                    }
                }
                _ = stackSymbol.pop()
            default:
                break
            }
        }
    }
    
    
    mutating func equal() {
        while !stackSymbol.isEmpty {
            let temp = stackSymbol.pop()
            if temp! == "(" {
                break
            }
            stack.push(temp!)
        }
        
        while !stack.isEmpty {
            stackReverse.push(stack.pop()!)
        }
        
        while !stackReverse.isEmpty {
            let peekValue = stackReverse.pop()!
            
            switch peekValue {
            case let someOperand as Double:
                stack.push(someOperand)
            case let someSymbol as String:
                switch someSymbol {
                case "+":
                    let operand1 = stack.pop()! as! Double
                    let operand2 = stack.pop()! as! Double
                    stack.push(operand2+operand1)
                case "−":
                    let operand1 = stack.pop()! as! Double
                    let operand2 = stack.pop()! as! Double
                    stack.push(operand2-operand1)
                case "×":
                    let operand1 = stack.pop()! as! Double
                    let operand2 = stack.pop()! as! Double
                    stack.push(operand2*operand1)
                case "÷":
                    let operand1 = stack.pop()! as! Double
                    let operand2 = stack.pop()! as! Double
                    stack.push(operand2/operand1)
                default:
                    break
                }
            default:
                break
            }
            accumulator = (stack.peek() as! Double)
        }
        
    }
    
    
    
    mutating func setOperand(_ operand: Double) {
        stack.push(operand)
    }
    
    var result: Double? { //seperate public properties and...
        get {
            return accumulator
        }
    }
    
    mutating func AC() {
        while !stack.isEmpty {
            _ = stack.pop()
        }
        while !stackSymbol.isEmpty {
            _ = stackSymbol.pop()
        }
        while !stackReverse.isEmpty {
            _ = stackReverse.pop()
        }
    }
    
    
}
