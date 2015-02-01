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


class RootViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{
    var myRootRef = Firebase(url:"https://eventhype.firebaseio.com/events")
    let geoFire = GeoFire(firebaseRef: Firebase(url: "https://eventhype.firebaseio.com/events"))
    
    
    @IBOutlet weak var theMapView: MKMapView!
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.18, green: 0.83, blue: 0.89, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.topItem?.title = "Events"
        super.viewDidLoad()
        //myRootRef.unauth()
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
        
        var info2 = CustomPointAnnotation()
        
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
        
        
        //using Firebase to gather events data and map pins to the map
        myRootRef.observeEventType(.ChildAdded, withBlock: { snapshot in

            //grabbing event values from firebase
            var address: AnyObject? = snapshot.value.objectForKey("address")
            var eventName: AnyObject? = snapshot.value.objectForKey("event_name")
            var eventDate: AnyObject? = snapshot.value.objectForKey("event_date");
          
            //placing the event on the map
            var geocoder = CLGeocoder()
            geocoder.geocodeAddressString(address as NSString, {(placemarks: [AnyObject]!, error: NSError!) -> Void in
                if let placemark = placemarks?[0] as? CLPlacemark {
                    var location: CLLocation = placemark.location
                    var coord=CLLocationCoordinate2DMake(location.coordinate.latitude,location.coordinate.longitude)
                    let annotation =  CustomPointAnnotation()
                    annotation.setCoordinate(coord)
                    annotation.title=snapshot.value["event_name"] as String!
                    annotation.imageName = "pinsmallspaced.png"
                    self.theMapView.addAnnotation(annotation)
                    //self.theMapView.addAnnotation(MKPlacemark(placemark: placemark))
                }
            })
    })

        
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
    
    func mapView(mapView: MKMapView!, annotationView: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if control == annotationView.rightCalloutAccessoryView {
            println("Disclosure Pressed! \(self.title)")
        }
    }
    
    
    
    
    
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        if !(annotation is CustomPointAnnotation) {
            return nil
        }
        
        let reuseId = "test"
        
        var anView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
        if anView == nil {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            anView.canShowCallout = true
            anView.rightCalloutAccessoryView = UIButton.buttonWithType(UIButtonType.ContactAdd) as UIButton
        }
        else{
            anView.annotation = annotation
        }
        
        //Set annotation-specific properties **AFTER**
        //the view is dequeued or created...
        
        let cpa = annotation as CustomPointAnnotation
        anView.image = UIImage(named:cpa.imageName)
        
        return anView
    }
    
    class CustomPointAnnotation: MKPointAnnotation {
        var imageName: String!
    }
    
}

