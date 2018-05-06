//
//  LoginViewController.swift
//  instagram_demo
//
//  Created by Elizabeth on 2/21/18.
//  Copyright © 2018 Elizabeth. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.

    }
    
    @IBAction func onLogIn(_ sender: Any) {
        
        print("User tapped the login button")
        
        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if user != nil {
                print("User with username \(self.usernameField.text!) logged in.")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                 print(error?.localizedDescription ?? "User log in failed:")
            }
  /*          if let error = error {
                print("User log in failed: \(error.localizedDescription)")
            } else {
                print("User logged in successfully")
            
            }
 */
        }
        // display view controller that needs to shown after successful login
        self.performSegue(withIdentifier: "loginSegue", sender: self)
    }
    
    
    @IBAction func onSignup(_ sender: Any) {
        self.performSegue(withIdentifier: "SignupPagesegue", sender: nil)
    }
    
}
