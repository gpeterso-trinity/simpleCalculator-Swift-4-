//
//  ViewController.swift
//  Calculator
//
//  Created by gpeterso on 3/3/18.
//  Copyright © 2018 gpeterso. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var expressionString:String = "0"
    var isDisplayingResult = false
    var canAddDecimal = true
    var answer:String = "0"
    
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        if expressionString.last != " " {
            if (isDisplayingResult || expressionString.count == 1) {
                expressionString = "0"
            } else {
                if expressionString != "0" {
                    if expressionString.last == "." {
                        canAddDecimal = true
                    }
                    expressionString.removeLast()
                }
            }
            updateText()
        }
    }
    @IBAction func memoryButtonPressed(_ sender: UIButton) {
        //memoryButton.setTitle(answer, for: UIControlState.normal)
    }
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        expressionString = "0"
        updateText()
        canAddDecimal = true
    }
    @IBAction func multiplyButtonPressed(_ sender: UIButton)    { addOperand(" * ") }
    @IBAction func sevenButtonPressed(_ sender: UIButton)       { addNumber("7") }
    @IBAction func eightButtonPressed(_ sender: UIButton)       { addNumber("8") }
    @IBAction func nineButtonPressed(_ sender: UIButton)        { addNumber("9") }
    @IBAction func divideButtonPressed(_ sender: UIButton)      { addOperand(" / ") }
    @IBAction func fourButtonPressed(_ sender: UIButton)        { addNumber("4") }
    @IBAction func fiveButtonPressed(_ sender: UIButton)        { addNumber("5") }
    @IBAction func sixButtonPressed(_ sender: UIButton)         { addNumber("6") }
    @IBAction func minusButtonPressed(_ sender: UIButton)       { addOperand(" - ") }
    @IBAction func oneButtonPressed(_ sender: UIButton)         { addNumber("1") }
    @IBAction func twoButtonPressed(_ sender: UIButton)         { addNumber("2") }
    @IBAction func threeButtonPressed(_ sender: UIButton)       { addNumber("3") }
    @IBAction func plusButtonPressed(_ sender: UIButton)        { addOperand(" + ") }
    @IBAction func zeroButtonPressed(_ sender: UIButton)        { addNumber("0") }
    @IBAction func decimalButtonPressed(_ sender: UIButton) {
        if canAddDecimal {
            if isDisplayingResult {
                expressionString = "0."
                smallDisplay.isHidden = true
                isDisplayingResult = false
            } else {
                expressionString.append(".")
            }
            updateText()
            canAddDecimal = false
        }
    }
    @IBAction func equalsButtonPressed(_ sender: UIButton) {
        if expressionString.last != " " {
            answer = evaluateExpression(expressionString)
            bigDisplay.text = "= \(answer)"
            smallDisplay.text = expressionString
            smallDisplay.isHidden = false
            isDisplayingResult = true
            canAddDecimal = true
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        updateText()
    }
    @IBOutlet weak var bigDisplay: UILabel!
    @IBOutlet weak var smallDisplay: UILabel!
    @IBOutlet weak var memoryButton: UIButton!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    func updateText() {
        bigDisplay.text = expressionString
    }
    func addNumber(_ num:String) {
        if expressionString.count + 1 <= 20 {
            if isDisplayingResult {
                expressionString = "0"
                smallDisplay.isHidden = true
                isDisplayingResult = false
                addNumber(num)
            } else {
                if expressionString != "0" {
                    expressionString.append(num)
                } else {
                    expressionString = num
                }
                updateText()
            }
        }
    }
    func addOperand(_ op:String) {
        if (expressionString != "0" && expressionString.count + 6 <= 20) {
            if isDisplayingResult {
                if (op == " / " && canAddDecimal) {
                    answer.append(".0")
                }
                expressionString = answer + op
                smallDisplay.isHidden = true
                isDisplayingResult = false
            } else {
                if (op == " / " && canAddDecimal) {
                    expressionString.append(".0")
                }
                expressionString.append(op)
            }
            canAddDecimal = true
        }
        updateText()
    }
    func evaluateExpression(_ str:String) -> String {
        let expression = NSExpression(format:str)
        if let result = expression.expressionValue(with: nil, context: nil) as? NSNumber {
            //print(expression)
            expressionString = String(describing: expression)
            //print("= \(result)")
            //print(" ")
            return String(describing: result)
        } else {
            //print("error evaluating expression")
            return "error evaluating expression"
        }
    }
}

