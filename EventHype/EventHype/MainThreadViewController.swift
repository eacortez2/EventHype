//
//  MainThreadViewController.swift
//  EventHype
//
//  Created by Zachary Feinn on 1/31/15.
//  Copyright (c) 2015 SBHacks. All rights reserved.
//

import UIKit

class MainThreadViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var messagesAry:[Comment] = []
    
    var testDict = ["userName": "", "chatText": "", "timeStamp": ""]
    
    
    // DEALING WITH FIREBASE
    // Create a reference to a Firebase location
    var messagesRef = Firebase(url:"https://torid-fire-984.firebaseio.com/testchat")
    //var messagesRef = Firebase(url:"https://eventhype.firebaseio.com/events")
    
    var eventName: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("\(eventName)")
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        messagesRef.observeEventType(.ChildAdded, withBlock: { (snapshot) in
            let text = snapshot.value["text"] as? String
            let sender = snapshot.value["sender"] as? String
            
            let comment = Comment(text: text, sender: sender)
            self.messagesAry.append(comment)
            println(comment)
            
            
            //Note that the strong self causes a memory leak!
            self.tableView.reloadData()
        })
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    @IBOutlet var tableView:UITableView!
    //TABLE setup
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messagesAry.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("celltest", forIndexPath: indexPath) as CommentCell
        
        
        cell.messageText.text = messagesAry[messagesAry.count - indexPath.row - 1].text()
        
        cell.numVotes.text = "\((indexPath.row + 1) * 5)"
        cell.timeSincePost.text = "\((indexPath.row + 1) * 3)m ago"
        cell.numReplies.text = "\((indexPath.row + 1) * 1) replies"
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //write code here for doing comments to posts in the main feed
    }
    
    
    
    @IBAction func upVote(sender: AnyObject) {
        let hitPoint = sender.convertPoint(CGPointZero, toView: self.tableView)
        let hitIndex = self.tableView.indexPathForRowAtPoint(hitPoint)
        
        NSLog("Top Index Path \(hitIndex?.row)")
        
        
    }
    
    
    @IBAction func downVote(sender: AnyObject) {
        let hitPoint = sender.convertPoint(CGPointZero, toView: self.tableView)
        let hitIndex = self.tableView.indexPathForRowAtPoint(hitPoint)
        NSLog("Bottom Index Path \(hitIndex?.row)")
        
    }
    
    
    
    @IBOutlet var messageTextInput:UITextView!
    
    @IBAction func messageSubmit(sender: AnyObject) {
        
        
        
        
        postMessage(messageTextInput.text, sender: "testSender")
        
        
        
        
        //        var testText = (jsonTest["timeStamp"].stringValue)
        //        println("SwiftyJSON: \(testText)")
        
        //myRootRef.setValue(messageTextInput.text)
        
        //yaks.append(messageTextInput.text)
        
        tableView.reloadData()
        
    }
    
    
    
    
    // GET RID OF TEXTFIELD IF USER CLICKS ELSEWHERE
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
        
    }
    
    
    
    //Post to FIREBASE
    func postMessage(text: String!, sender: String!) {
        
        var tempMessageRef = messagesRef.childByAutoId()
        
        tempMessageRef.setValue([
            "text":text,
            "sender":sender
            
            //implement image if you want to
            //"imageUrl":senderImageUrl
            
            ])
        
        //        var tempString = toString(tempMessageRef)
        //        var tempStringAry = tempString.componentsSeparatedByString("-")
        //        println(tempStringAry[tempStringAry.count - 1])
        //        messageRefAry.append("-" + tempStringAry[tempStringAry.count - 1])
    }
    
    
    
    
    // NO SUBMISSION FOR EMPTY TEXT
    // LIMIT ON SUBMISSIONS IN A ROW
    // SHow off error handling
}

