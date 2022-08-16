//
//  Calculator.swift
//  D00
//
//  Created by Kyu jin Lee on 2022/08/16.
//

import Foundation
import UIKit


class Calculator: UIViewController {
    
    @IBOutlet weak var result: UILabel!
    var sum = 0
    var num = 0
    var opp = ""
    var userTyping = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func numbers(_ sender: UIButton){
        if( result.text == "0"){
            result.text = ""
        }
        let text = sender.currentTitle!
        if userTyping {
            let tmp = result.text!
            result.text = tmp + text
        }else{
            result.text = text
        }
        userTyping = true;
    }
    
    func op(_ op: Character) {
        num = Int(result.text!)!
        
        switch op {
        case "+" : sum += num
        case "-" : sum -= num
        case "*" : sum *= num
        case "/" : sum /= num
        default:
            break;
        }
        userTyping = false
        result.text = String(sum)
    }
    
    @IBAction func operators(_ sender: UIButton) {
        let tmp = sender.currentTitle!
        print(sum)
        switch tmp {
        case "+" : op("+")
        case "-" : op("-")
        case "*" : op("*")
        case "/" : op("/")
        default:
            break;
        }
    }
        
}
