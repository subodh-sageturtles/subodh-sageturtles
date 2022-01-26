//
//  signInViewController.swift
//  GCSCMgmtApp
//
//  Created by Kumar, Subodh on 1/11/22.
//

import UIKit

class signInViewController: UIViewController {

    @IBOutlet weak var logoImg: UIImageView!
    @IBOutlet weak var signInLbl: UILabel!
    
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwdLbl: UILabel!
    @IBOutlet weak var passwdTxt: UITextField!
    @IBOutlet weak var signInBtn: UIButton!
    
    var user:User?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.user = User()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        //Fix exceptions later TBD
        self.user?.email = emailTxt.text!
        //Value fetched from database after successful signin
        self.user?.id = 12345
        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        //let ptVC = segue.destination as! projectTaskViewController
        //ptVC.user = self.user
    }


}
