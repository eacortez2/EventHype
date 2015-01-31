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
    
    
    override func viewDidLoad() {
        //we need to pull the data from the firebase chat and figure out how many rows we need
        
    }
    

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 2
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return 1
        
    }
    
   override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = String("test")
        
        return cell
    }
    
}
