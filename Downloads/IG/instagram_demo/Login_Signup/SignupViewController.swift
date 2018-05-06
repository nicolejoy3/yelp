//
//  SignupViewController.swift
//  instagram_demo
//
//  Created by Elizabeth on 2/21/18.
//  Copyright © 2018 Elizabeth. All rights reserved.
//

import UIKit
import  Parse

class SignupViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onRegister(_ sender: Any) {
        
        // initialize a user object
        let newUser = PFUser()
        
        // set user properties
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        newUser.email = emailField.text
        
        // call sign up function on the object
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            
            if success {
                print("Created a user with username \(newUser.username!)")
                // display loginview
                self.performSegue(withIdentifier: "signupSegue", sender: nil)
            } else {
                print(error?.localizedDescription ?? "User log in failed:")
                
                if error?._code == 202 {
                    print("The Username \(self.usernameField.text!) is taken")
                }
            }
            
            
        
        
/*            if let error = error {
                print(error.localizedDescription)
                
                if error._code == 202 {
                    print("Username is taken")
                }
                
            } else {
                print("User Registered successfully")
                // manually segue to logged in view
                self.performSegue(withIdentifier: "signupSegue", sender: nil)
            }
 */
            
        }
    }
   
    
    @IBAction func loginBack(_ sender: Any) {
        self.performSegue(withIdentifier: "LoginBackSegue", sender: sender)
    }
    
}
