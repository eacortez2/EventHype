//
//  ViewController.swift
//  EventHype
//
//  Created by Russ Fenenga on 1/30/15.
//  Copyright (c) 2015 SBHacks. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    var myRootRef = Firebase(url:"https://eventhype.firebaseio.com")

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "registerView@2x.jpg")!)
    }
    override func viewDidAppear(animated: Bool) {
        myRootRef.observeAuthEventWithBlock({ authData in
            if authData != nil {
                // user authenticated with Firebase
                //println(authData)
            } else {
                // No user is logged in
                self.performSegueWithIdentifier("gotoLogin", sender: self)
            }
        })
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func logoutButtonPressed(sender: UIButton) {
        myRootRef.unauth()
        self.performSegueWithIdentifier("gotoLogin", sender: self)
    }

}

