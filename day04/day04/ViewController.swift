//
//  ViewController.swift
//  day04
//
//  Created by Kyu jin Lee on 2022/08/22.
//

import UIKit

class ViewController: UIViewController {

    var appId = "0bee1a03e1b2a65733bbfcafe5f67e37bc9ba0349e98f08707650008f37cc2da"
    var appSecret = "8c6417576210eb6c9e4a5c0213ac728bc6b6b7521f5077bc891f34dddbde392b"
    var apiTokenUrl = URL(string: "https://api.intra.42.fr/oauth/token")
    var token: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getToken()
    }
    
    func getToken() {
            let parameters = [
                "grant_type": "client_credentials",
                "client_id": self.appId,
                "client_secret": self.appSecret]
            let paramData = try! JSONSerialization.data(withJSONObject: parameters, options: [])
            
            var request = URLRequest(url: self.apiTokenUrl!)
            request.httpMethod = "POST"
            request.httpBody = paramData
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(String(paramData.count), forHTTPHeaderField: "Content-Length")
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                guard let data = data, error == nil else {
                    print("error=\(String(describing: error))")
                    return
                }
                
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(String(describing: response))")
                }
                
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject]
                self.token = json!["access_token"] as? String
            }
            
            task.resume()
            print(self.token)

        }

}

