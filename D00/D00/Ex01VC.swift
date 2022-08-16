//
//  Ex00VC.swift
//  D00
//
//  Created by Kyu jin Lee on 2022/08/16.
//

import UIKit

class Ex01ViewController: UIViewController {
    var ho: Bool = true
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func toggle(_ sender: Any) {
        if ho == true {
            label.text = "hi"
        } else {
            label.text = ""
        }
        ho.toggle()
    }
    
}
