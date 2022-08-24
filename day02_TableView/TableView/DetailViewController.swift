//
//  DetailViewController.swift
//  day02
//
//  Created by Kyu jin Lee on 2022/08/18.
//

import UIKit

class DetailViewController: UIViewController {

	var receiveSubject = ""
	
	@IBOutlet weak var lblItem: UILabel!
	
	override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		lblItem.text = receiveSubject
    }
	
	func receiveSubject(_ subject: String) {
		receiveSubject = subject
	}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
