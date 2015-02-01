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
        eventList.dataSource=self
        eventList.delegate=self
        
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        var count:UInt = 0
        // Retrieve new posts as they are added to Firebase
        myRootRef.observeEventType(.ChildAdded, withBlock: { snapshot in
            count++
            println("added -> \(snapshot.value)")
        })
        // snapshot.childrenCount will always equal count since snapshot.value will include every FEventTypeChildAdded event
        // triggered before this point.
        myRootRef.observeEventType(.Value, withBlock: { snapshot in
            println("initial data loaded! \(count == snapshot.childrenCount)")
        })
        return Int(count)
    }
    
   override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = String("test")
        
        return cell
    }
    
}
