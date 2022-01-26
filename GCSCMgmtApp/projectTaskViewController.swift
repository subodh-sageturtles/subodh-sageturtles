//
//  projectTaskViewController.swift
//  GCSCMgmtApp
//
//  Created by Kumar, Subodh on 1/12/22.
//

import UIKit

class projectTaskViewController: UIViewController {
    var user:User?
    
    @IBOutlet weak var textLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.textLbl.text = self.user?.email
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
