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
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.18, green: 0.83, blue: 0.89, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.topItem?.title = "My Events"
        eventList.dataSource=self
        eventList.delegate=self
        setUpFireBase()
    }
    
    func setUpFireBase(){
        myRootRef.observeEventType(.ChildAdded, withBlock: { snapshot in
            println("added -> \(snapshot.value)")
        })
        myRootRef.observeEventType(.Value, withBlock: { snapshot in
            
        })

        
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return 1
    }
    
   override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
    let cell = tableView.dequeueReusableCellWithIdentifier("eventNameCell", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = String("test")
        
        return cell
    }
    
}
