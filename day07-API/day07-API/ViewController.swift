//
//  ViewController.swift
//  day07-API
//
//  Created by Kyu jin Lee on 2022/08/25.
//

import UIKit
import RecastAI
import ForecastIO
import JSQMessagesViewController
import CoreLocation

class ViewController: UIViewController {
    var bot : RecastAIClient?
    var client : DarkSkyClient?
    
    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var output: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.bot = RecastAIClient(token : "c80f802ac6dd241654df237385b351b5")
        self.client = DarkSkyClient(apiKey: "bdd66f06868425fe86f8b98270d7da67")
        self.client?.units = .si
    }

    @IBAction func getWeather(_ sender: UIButton) {
        self.bot?.textRequest(input.text!, successHandler: successHandler) { error in
                print(error.localizedDescription)
        }
    }
    
    private func successHandler(response : Response) {
        if let location = response.get(entity: "location") {
            if let city = location["city"] as? String {
                self.output.text = "Weather in \(city) is "
            } else if let formatted = location["formatted"] as? String {
                self.output.text = "Weather in \(formatted) is "
            }
            let myLoc = CLLocationCoordinate2D(latitude: location["lat"]! as! CLLocationDegrees, longitude: location["lng"]! as! CLLocationDegrees)
            self.client!.getForecast(location: myLoc) { result in
                switch result {
                case .success((let currentForecast, _)):
                    DispatchQueue.main.async {
                        self.output.text = self.output.text! + String(describing: currentForecast.currently!.summary!) + "\nTemperature is \(String(describing: currentForecast.currently!.temperature!))°C"
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}

