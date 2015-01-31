//
//  ViewController.swift
//  EventHype
//
//  Created by turbs on 1/30/15.
//  Copyright (c) 2015 SBHacks. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class RootViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    var myRootRef = Firebase(url:"https://eventhype.firebaseio.com")
    let geoFire = GeoFire(firebaseRef: Firebase(url: "https://eventhype.firebaseio.com"))
    
    
    @IBOutlet weak var theMapView: MKMapView!
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "registerView@2x.jpg")!)
        
        //getting the user's location
        if(CLLocationManager.locationServicesEnabled()){
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
        
        //hard coded location variables for the UCen
        var latitude: CLLocationDegrees = 34.411572
        var longitude: CLLocationDegrees = -119.844186
        
        var currentLocation = locationManager.location
        if currentLocation != nil{
            var latitude: CLLocationDegrees = currentLocation.coordinate.latitude
            var longitude: CLLocationDegrees = currentLocation.coordinate.longitude
            
        }
        
        
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

