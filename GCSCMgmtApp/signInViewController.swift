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
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.user?.email = emailTxt.text!
        let destinationViewController = segue.destination as! TableViewController
        destinationViewController.userEmail = self.user?.email
    }
}
