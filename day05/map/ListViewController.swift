//
//  ViewController.swift
//  day05
//
//  Created by kyujlee on 2022/08/23.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableview: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        PlaceList.places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = (PlaceList.places[indexPath.row].title! ?? "Ups") + " – " + (PlaceList.places[indexPath.row].subtitle! ?? "upsu")

        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showOnMap", sender: self) //아래있는 prepare에 특정 segue를 보내주는 역할
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        tableview.reloadData()
        // Do any additional setup after loading the view.
        
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        tableview.reloadData()
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  let indexPath = tableview.indexPathForSelectedRow {
            let destinationView = segue.destination as! PlaceMapController//performSegue에서 받은 값을 통해 세그의 목적지 VC를 추출하는 과정
            destinationView.placeToShow = PlaceList.places[indexPath.row]
        }
    }
    
}
