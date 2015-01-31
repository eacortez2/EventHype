//
//  ViewController.swift
//  EventHype
//
//  Created by Russ Fenenga on 1/30/15.
//  Copyright (c) 2015 SBHacks. All rights reserved.
//

import UIKit
import MapKit

class RootViewController: UIViewController, MKMapViewDelegate {
    var myRootRef = Firebase(url:"https://eventhype.firebaseio.com")

    @IBOutlet weak var theMapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "registerView@2x.jpg")!)
        
        //hard coded location variables for the UCen
        var latitude: CLLocationDegrees = 34.411572
        var longitude: CLLocationDegrees = -119.844186
        
        
        //variables to control the starting zoom area
        var latDelta: CLLocationDegrees = 0.08
        var longDelta: CLLocationDegrees = 0.08
        
        //now actually setting the starting zoom area
        var theSpan:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta);
        
        //now actually setting starting point on map
        var usersLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        //combining all the information into a single variable
        var theRegion: MKCoordinateRegion = MKCoordinateRegionMake(usersLocation, theSpan)
        
        self.theMapView.setRegion(theRegion, animated: true)
        
        
        
        
        
        
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

