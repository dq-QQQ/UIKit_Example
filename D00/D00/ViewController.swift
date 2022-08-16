//
//  ViewController.swift
//  D00
//
//  Created by Kyu jin Lee on 2022/08/16.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    var ho = 0
    
    @IBAction func click(_ sender: Any) {
        
        ho += 1
        print("ho ", ho)
    }
}

