//
//  LoginViewController.swift
//  EventHype
//
//  Created by Russ Fenenga on 1/30/15.
//  Copyright (c) 2015 SBHacks. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var customSignInButton: UIButton!
    var myRootRef = Firebase(url:"https://eventhype.firebaseio.com")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "3 - Pcap0hn@2x.jpg")!)
        customSignInButton.layer.cornerRadius = 27
        emailTextField.text = ""
        emailTextField.delegate=self
        passwordTextField.delegate=self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signInPressed(sender: UIButton) {
        myRootRef.authUser("\(emailTextField.text)", password: "\(passwordTextField.text)",
            withCompletionBlock: { error, authData in
                if error != nil {
                    if let errorCode = FAuthenticationError(rawValue: error.code) {
                        switch (errorCode) {
                        case .UserDoesNotExist:         //no user exists in the database with that info
                            var notficationAlert = UIAlertController(title: "User Not Found", message: "The user was not able to be found.", preferredStyle: UIAlertControllerStyle.Alert)
                            
                            notficationAlert.addAction(UIAlertAction(title: "Try Again", style: .Default, handler: { (action: UIAlertAction!) in
                                notficationAlert.dismissViewControllerAnimated(true, completion: nil)
                            }))
                            self.presentViewController(notficationAlert, animated: true, completion: nil)
                            break
                        case .InvalidEmail:            //invalid email
                            var notficationAlert = UIAlertController(title: "Invalid Email", message: "The entered email was invalid.", preferredStyle: UIAlertControllerStyle.Alert)
                            
                            notficationAlert.addAction(UIAlertAction(title: "Try Again", style: .Default, handler: { (action: UIAlertAction!) in
                                notficationAlert.dismissViewControllerAnimated(true, completion: nil)
                            }))
                            self.presentViewController(notficationAlert, animated: true, completion: nil)
                            break
                        case .InvalidPassword:          //invalid password
                            var notficationAlert = UIAlertController(title: "Invalid Password", message: "The entered password was incorrect.", preferredStyle: UIAlertControllerStyle.Alert)
                            
                            notficationAlert.addAction(UIAlertAction(title: "Try Again", style: .Default, handler: { (action: UIAlertAction!) in
                                notficationAlert.dismissViewControllerAnimated(true, completion: nil)
                            }))
                            self.presentViewController(notficationAlert, animated: true, completion: nil)
                            break
                        default:
                            var notficationAlert = UIAlertController(title: "Unknown Error", message: "Could not sign you in, Please try again.", preferredStyle: UIAlertControllerStyle.Alert)
                            
                            notficationAlert.addAction(UIAlertAction(title: "Try Again", style: .Default, handler: { (action: UIAlertAction!) in
                                notficationAlert.dismissViewControllerAnimated(true, completion: nil)
                            }))
                            self.presentViewController(notficationAlert, animated: true, completion: nil)
                            break
                        }
                    }
                    
                } else {
                    // We are now logged in
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
        })
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }

}
