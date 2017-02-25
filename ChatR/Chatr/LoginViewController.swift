//
//  ViewController.swift
//  Chatr
//
//  Created by Enzo Ames on 2/23/17.
//  Copyright © 2017 Enzo Ames. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController
{

    //||||||||||||||||||||||||||||||||||||||
    //||||||||||||||||VARIABLES|||||||||||||
    //||||||||||||||||||||||||||||||||||||||
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func onTapLogin(_ sender: Any)
    {
    
        PFUser.logInWithUsername(inBackground: emailField.text! , password: passwordField.text!)
        {
            (user: PFUser?, error: Error?) -> Void in
            
            if(user != nil)
            {
                print("Loged In ! ")
                
                self.performSegue(withIdentifier: "LoginSegue", sender: nil )
                
            }
            else
            {
                print("error: \(error?.localizedDescription)")
            }
        
        }
    }
    
    
    func onTapSignup(_ sender: Any)
    {
        let user = PFUser()
        
        user.username = emailField.text!
        user.password = passwordField.text!
        
        user.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error
            {
                print("Error: \(error.localizedDescription)")
                self.onTapLogin(Any.self)
            }
            else
            {
                print("Signed up!")
            }
        }
    }

    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
//    {
//    
//        // Get the new view controller using segue.destinationViewController.
//
//        let chatViewController = segue.destination as! ChatViewController
//        
//        // Pass the selected object to the new view controller.
//    }
//    

    
    
    
    
}














