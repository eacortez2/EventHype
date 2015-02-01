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
    
    override func viewDidLoad() {
        eventList.dataSource=self
        eventList.delegate=self
        
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        // Retrieve new posts as they are added to Firebase
        myRootRef.observeEventType(.ChildAdded, withBlock: { snapshot in
            println("added -> \(snapshot.value)")
        })
        // snapshot.childrenCount will always equal count since snapshot.value will include every FEventTypeChildAdded event
        // triggered before this point.
        myRootRef.observeEventType(.Value, withBlock: { snapshot in
            
        })
        return 1
    }
    
   override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
    let cell = tableView.dequeueReusableCellWithIdentifier("eventNameCell", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = String("test")
        
        return cell
    }
    
}
