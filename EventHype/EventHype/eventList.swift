//
//  eventList.swift
//  EventHype
//
//  Created by Russ Fenenga on 1/31/15.
//  Copyright (c) 2015 SBHacks. All rights reserved.
//

import UIKit

class eventList: UITableViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var eventList: UITableView!
    var myRootRef = Firebase(url:"https://eventhype.firebaseio.com")
    var numberRows: UInt = 0
    
    
    override func viewDidLoad() {
        //we need to pull the data from the firebase chat and figure out how many rows we need
        myRootRef.observeEventType(.ChildAdded, withBlock: { snapshot in
            self.numberRows=snapshot.childrenCount
            println("\(self.numberRows)")
        })
    }
    

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 5
    }
    
   override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = String("test")
        
        return cell
    }
    
}
