//
//  TableViewController.swift
//  hohohoho
//
//  Created by Kyu jin Lee on 2022/08/18.
//

import UIKit

var ho: [(String,String,String)] = [ ("ho","ho2","ho3\n\n\n\n\n\n\n\n\n\n"),("ho4","ho5","ho6"),("ho7","ho8","ho9"),("ho10","ho11","ho12")]

class customTableCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var date: UILabel!
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

class AddViewController: UIViewController {
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var date: UIDatePicker!
    @IBOutlet weak var des: UITextField!
    var hoho: (String, String, String) = ("", "", "")
    @IBAction func add(_ sender: Any) {
        hoho = (name.text!, date.description, des.text!)
        ho.append(hoho)
        _ = navigationController?.popViewController(animated: true)
    }
}

class TableViewController: UITableViewController {

    @IBOutlet var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 200
    }
            
            override func viewWillAppear(_ animated: Bool) {
                tableview.reloadData()
            }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "first", for: indexPath) as! customTableCell
        
        var content = cell.defaultContentConfiguration()

        // Configure content.

        content.text = ho[indexPath.row].0 + "\t\t\t\t\t\t\t\t" + ho[indexPath.row].1
        content.secondaryText = ho[indexPath.row].2
        content.textProperties.color = .red
        content.secondaryTextProperties.color = .blue

        cell.contentConfiguration = content
        
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
