//
//  ViewController.swift
//  EventHype
//
//  Created by Russ Fenenga on 1/30/15.
//  Copyright (c) 2015 SBHacks. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var myRootRef = Firebase(url:"https://eventhype.firebaseio.com")

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        println("Hello World")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

