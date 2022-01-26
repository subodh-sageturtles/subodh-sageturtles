//
//  TableViewController.swift
//  GCSCMgmtApp
//
//  Created by Kumar, Subodh on 1/14/22.
//

import UIKit

struct cellData {
    var opened = Bool()
    var title = String ()
    var sectionData = [String]()
}

class TableViewController: UITableViewController {
    var tableViewData = [cellData]()
    //var items = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
       // ToDo: Hardcoded string needs to be replaced with data detched from database, each array element is a row, each string the array element is a field in some table, and each line is a row. Each celldata is different set of data from a different query.
        
        tableViewData = [cellData(opened: false, title: "Upcoming Deadlines", sectionData:["Amit Varde " + "install power outlet" + " " + "01-29-2022" + " " + "Sunnyvale CA " , "Subodh Kumar" + " " + "install projector" + " " + "01-27-2022" + " " + "Austin TX"]),
        cellData(opened: false, title: "Todays Tasks", sectionData: ["Kenneth Chang" + " " + "install sink" + " " + "TodaysDate" + " " + "Sunnyvale CA "]),
        cellData(opened: false, title: "Projects", sectionData: ["Amit Varde  " + " " + "install dishwasher" + " " + "02-05-2022" + " " + "Sunnyvale CA "
        , "Subodh Kumar" + " " + "install cabinets" + " " + "01-28-2022" + " " + "Austin TX"])]
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if tableViewData[section].opened == true {
            return tableViewData[section].sectionData.count + 1
        } else {
            return 1
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {return UITableViewCell()}
            cell.textLabel?.text = tableViewData[indexPath.section].title
            if cell.textLabel?.text == "Upcoming Deadlines" {
                cell.backgroundColor = UIColor.red
                cell.textLabel?.textColor = UIColor.white
            } else if cell.textLabel?.text == "Todays Tasks" {
                cell.backgroundColor = UIColor.blue
                cell.textLabel?.textColor = UIColor.white
            } else {
                cell.backgroundColor = UIColor.cyan
                cell.textLabel?.textColor = UIColor.black
            }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {return UITableViewCell()}
            cell.textLabel?.text = tableViewData[indexPath.section].sectionData[indexPath.row - 1]
            cell.backgroundColor = UIColor.white
            cell.textLabel?.textColor = UIColor.black
            return cell
            }
        }

    override func tableView(_ tableView: UITableView, didSelectRowAt  IndexPath: IndexPath){
        if IndexPath.row == 0 {
            if tableViewData[IndexPath.section].opened == true {
                tableViewData[IndexPath.section].opened = false
                let sections = IndexSet.init(integer: IndexPath.section)
                tableView.reloadSections(sections, with: .none)
            }else {
                tableViewData[IndexPath.section].opened = true
                let sections = IndexSet.init(integer: IndexPath.section)
                tableView.reloadSections(sections, with: .none)
            }
        }
    }
    // MARK: - Table view data source


    
    
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
