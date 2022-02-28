//
//  TableViewController.swift
//  GCSCMgmtApp
//
//  Created by Kumar, Subodh on 1/14/22.
//

import UIKit
import SQLite3

struct cellData {
    var opened = Bool()
    var title = String ()
    var sectionData = [String]()
}

func openDatabase() -> OpaquePointer? {
    do {var db: OpaquePointer?
    let manager = FileManager.default
        let testDbPath = try manager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create:false).appendingPathComponent("test.db")
    if sqlite3_open(testDbPath.path, &db) == SQLITE_OK {
        print(" Successfully opened connection to database at \(testDbPath)")
        return db
    } else {
        print("Unable to open database.")
        return nil
    }
        //return nil
    } catch {
        print(error)
        return nil
    }
    
}

func queryDeadline(in db:OpaquePointer, in queryStatementString:String) ->  Array<String>{
    var arr:[String] = ["MainContractID || ContractID || ContractorName || Task || DueDate"]
    var i=0
    var queryStatement: OpaquePointer?
    if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
        while (sqlite3_step(queryStatement) == SQLITE_ROW) {
            arr.append(String(cString: sqlite3_column_text(queryStatement,0)) + " || " +
            String(cString: sqlite3_column_text(queryStatement,1)) + " || " +
            String(cString: sqlite3_column_text(queryStatement,2))  + " || " +
            String(cString: sqlite3_column_text(queryStatement,3))  + " || " +
            String(cString: sqlite3_column_text(queryStatement,4)))
            i+=1
        }
    }
    debugPrint(arr)
    sqlite3_finalize(queryStatement)
    return arr
}

// Will merge these query functions into one later
func queryProposalsView(in db:OpaquePointer, in queryStatementString:String) ->  Array<String>{
    var arr:[String] = ["customername || worklocation || completiondeadline || worksummary || budgetlimit"]
    var i=0
    var queryStatement: OpaquePointer?
    if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
        while (sqlite3_step(queryStatement) == SQLITE_ROW) {
            arr.append(String(cString: sqlite3_column_text(queryStatement,0)) + " || " +
            String(cString: sqlite3_column_text(queryStatement,1)) + " || " +
            String(cString: sqlite3_column_text(queryStatement,2))  + " || " +
            String(cString: sqlite3_column_text(queryStatement,3))  + " || " +
            String(cString: sqlite3_column_text(queryStatement,4)))
            i+=1
        }
    }
    debugPrint(arr)
    sqlite3_finalize(queryStatement)
    return arr
}


class TableViewController: UITableViewController {
    var tableViewData = [cellData]()
    var userEmail:String? = ""
    //var items = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let db = openDatabase()
        var lead:String = " ";
        lead = ", '+30 days'";
        let queryStringDeadline = "select * from taskdeadline where maincontractidentifier in (select contractid from contract where contractorid = (select contractorid from contractor where emailaddr = '" + userEmail! + "')) AND  duedate < DATE('now'" + lead + ");"
        lead = ", '+1 days'";
        let queryStringTodayTask = "select * from taskdeadline where maincontractidentifier in (select contractid from contract where contractorid = (select contractorid from contractor where emailaddr = '" + userEmail! + "')) AND  duedate < DATE('now'" + lead + ");"
        let queryStringProposals = "select * from vw_proposals;"
        var arrdeadline:[String] = []
        arrdeadline = queryDeadline(in:db!,in:queryStringDeadline)
        var arrTodayTask:[String] = []
        arrTodayTask = queryDeadline(in: db!, in: queryStringTodayTask)
        var arrProposals:[String] = []
        arrProposals = queryProposalsView(in: db!, in: queryStringProposals)
        sqlite3_close_v2(db)
        tableViewData = [cellData(opened: false, title: "Upcoming Deadlines", sectionData:arrdeadline),
        cellData(opened: false, title: "Todays Tasks", sectionData: arrTodayTask),
        cellData(opened: false, title: "Open Proposals", sectionData: arrProposals)]
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
