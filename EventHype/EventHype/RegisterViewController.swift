//
//  RegisterViewController.swift
//  EventHype
//
//  Created by Russ Fenenga on 1/30/15.
//  Copyright (c) 2015 SBHacks. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    var myRootRef = Firebase(url:"https://eventhype.firebaseio.com")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "registerView@2x.jpg")!)
        registerButton.layer.cornerRadius = 15
        emailTextField.delegate=self
        passwordTextField.delegate=self
        confirmPasswordTextField.delegate=self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func registerButtonPressed(sender: UIButton) {
        if(passwordTextField.text==confirmPasswordTextField.text){        //if passwords match create user
            myRootRef.createUser("\(emailTextField.text)", password: "\(passwordTextField.text)",
                withCompletionBlock: { error in
                    if error != nil {
                        // There was an error creating the account
                        println("error creating account")
                    } else {
                        // We created a new user account
                        println("account created")
                        self.dismissViewControllerAnimated(true, completion: nil)
                    }
            })
        } else {                //password mismatch so pop an alert up
            var notficationAlert = UIAlertController(title: "Password Mismatch", message: "Your passwords do not match", preferredStyle: UIAlertControllerStyle.Alert)
            
            notficationAlert.addAction(UIAlertAction(title: "Try Again", style: .Default, handler: { (action: UIAlertAction!) in
                notficationAlert.dismissViewControllerAnimated(true, completion: nil)
            }))
            presentViewController(notficationAlert, animated: true, completion: nil)
        }
    }
    
    
    
    @IBAction func goToLogin(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
}
