//
//  NewEventViewController.swift
//  EventHype
//
//  Created by turbs on 1/31/15.
//  Copyright (c) 2015 SBHacks. All rights reserved.
//

import Foundation
import UIKit

class NewEventViewController: UIViewController, UITextFieldDelegate{
    
    var myRootRef = Firebase(url:"https://eventhype.firebaseio.com/events")
    
    @IBOutlet weak var eventNameField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var publicSwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func AddEventPressed(sender: AnyObject) {
        
        
        //grab date from the date picker
        var chosenDate = self.datePicker.date
        
        //grab bool value from publicSwitch
        var isPublic = self.publicSwitch.on
        var setPublic = "true"
        if !isPublic{
            setPublic = "false"
        }
        
        
        //create a NSDateFormatter, but is doing nothing right now
        var formatter = NSDateFormatter()
        formatter.dateFormat = "dd-MM-yyyy HH:mm" //temporary format
        
        let dateStringForDisplay = formatter.stringFromDate(chosenDate)
        
        //grab event name and address values
        var eventName = eventNameField.text
        var addressName = addressField.text
        
        //submitting information to firebase
        
        
    
        var event = ["event_name": eventName, "address": addressName, "event_date": dateStringForDisplay, "public": setPublic ]
        var eventRef = myRootRef.childByAutoId()
        eventRef.setValue(event)

        var notficationAlert = UIAlertController(title: "Event Successfully Created", message: "We were able to create your event!", preferredStyle: UIAlertControllerStyle.Alert)
        
        notficationAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            notficationAlert.dismissViewControllerAnimated(true, completion: nil)
        }))
        self.presentViewController(notficationAlert, animated: true, completion: nil)
    }
    
   
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }

    
    
    
}



