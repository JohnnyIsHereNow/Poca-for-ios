//
//  MapViewController.swift
//  POCA
//
//  Created by Alexandru Draghi on 11/06/16.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {

    @IBOutlet weak var map: MKMapView!
    var myLocation:CLLocationCoordinate2D?

    let prefs = NSUserDefaults.standardUserDefaults()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Ask for Authorisation from the User.
        
        if #available(iOS 8.0, *) {
            self.locationManager.requestAlwaysAuthorization()
        } else {
            // Fallback on earlier versions
        }
        
        // For use in foreground
        if #available(iOS 8.0, *) {
            self.locationManager.requestWhenInUseAuthorization()
        } else {
            // Fallback on earlier versions
        }
        
        if CLLocationManager.locationServicesEnabled()
        {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        map.delegate = self
        map.mapType = .Standard
        map.zoomEnabled = true
        map.scrollEnabled = true
        
        showPointsOnMap()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        map.showsUserLocation = true;
    }
    
    override func viewWillDisappear(animated: Bool) {
        map.showsUserLocation = false
    }
    
    func addLongPressGesture(){
        let longPressRecogniser:UILongPressGestureRecognizer = UILongPressGestureRecognizer(target:self , action:#selector(MapViewController.handleLongPress(_:)))
        longPressRecogniser.minimumPressDuration = 1.0 //user needs to press for 2 seconds
        self.map.addGestureRecognizer(longPressRecogniser)
    }
    
    func handleLongPress(gestureRecognizer:UIGestureRecognizer){
        if gestureRecognizer.state != .Began{
            return
        }
        
        let touchPoint:CGPoint = gestureRecognizer.locationInView(self.map)
        let touchMapCoordinate:CLLocationCoordinate2D =
            self.map.convertPoint(touchPoint, toCoordinateFromView: self.map)
        
        let annot:MKPointAnnotation = MKPointAnnotation()
        annot.coordinate = touchMapCoordinate
        annot.title = prefs.objectForKey("USERNAME") as? String
    
        self.resetTracking()
        self.map.addAnnotation(annot)
        self.centerMap(touchMapCoordinate)
    }
    
    func resetTracking(){
        if (map.showsUserLocation){
            map.showsUserLocation = false
            self.map.removeAnnotations(map.annotations)
            self.locationManager.stopUpdatingLocation()
        }
    }
    
    func centerMap(center:CLLocationCoordinate2D){
        self.saveCurrentLocation(center)
        
        let spanX = 0.007
        let spanY = 0.007
        
        let newRegion = MKCoordinateRegion(center:center , span: MKCoordinateSpanMake(spanX, spanY))
        map.setRegion(newRegion, animated: true)
    }
    
    var i = 0
    func saveCurrentLocation(center:CLLocationCoordinate2D){
        let message = "\(center.latitude) , \(center.longitude)"
        print(message)
        myLocation = center
        if i == 0
        {
        saveLocation(center)
        i+=1
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        
        centerMap(locValue)
    }
    
    static var enable:Bool = true
    func getMyLocation(sender: UIButton)
    {
        
        if CLLocationManager.locationServicesEnabled() {
            if MapViewController.enable {
                locationManager.stopUpdatingHeading()
            }else{
                locationManager.startUpdatingLocation()
            }
            MapViewController.enable = !MapViewController.enable
        }
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView?
    {
        
        let identifier = "pin"
        var view : MKPinAnnotationView
        
        if let dequeueView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as? MKPinAnnotationView{
            dequeueView.annotation = annotation
            view = dequeueView
        }else{
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
        }
        view.pinColor =  .Red
        return view
    }
    
    func showPointsOnMap()
    {
        var x:Double = 0
        var y:Double = 0
        var username = prefs.objectForKey("USERNAME") as! String
        
        var newString = ""
        do {
            let post:NSString = "username=\(username)"
            
            NSLog("PostData: %@",post);
            
            let url:NSURL = NSURL(string:"http://angelicapp.com/POCA/jsonShowMap.php")!
            
            let postData:NSData = post.dataUsingEncoding(NSASCIIStringEncoding)!
            
            let postLength:NSString = String( postData.length )
            
            let request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
            request.HTTPMethod = "POST"
            request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
            request.HTTPBody = postData
            request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            
            var reponseError: NSError?
            var response: NSURLResponse?
            
            var urlData: NSData?
            do
            {
                urlData = try NSURLConnection.sendSynchronousRequest(request, returningResponse:&response)
            }
            catch let error as NSError
            {
                reponseError = error
                urlData = nil
            }
            
            if ( urlData != nil )
            {
                let res = response as! NSHTTPURLResponse!;
                
                //NSLog("Response code: %ld", res.statusCode);
                
                if (res.statusCode >= 200 && res.statusCode < 300)
                {
                    let responseData:NSString  = NSString(data:urlData!, encoding:NSUTF8StringEncoding)!
                    
                    NSLog("Response ==> %@", responseData);
                    
                    newString = responseData.substringFromIndex(0)
                    let newStringArr = newString.componentsSeparatedByString("+")
                    
                    if newStringArr.count != 0
                    {
                        for n in 0...newStringArr.count - 1
                        {
                            if newStringArr[n] != ""
                            {
                            let newStringArr2 = newStringArr[n].componentsSeparatedByString("/")
                            if newStringArr2[0] != prefs.objectForKey("USERNAME") as! String
                            {
                            username = newStringArr2[0]
                            x = Double(newStringArr2[1])!
                            y = Double(newStringArr2[2])!
                            let pinLocation : CLLocationCoordinate2D = CLLocationCoordinate2DMake(x, y)
                            let objectAnnotation = MKPointAnnotation()
                            objectAnnotation.coordinate = pinLocation
                            objectAnnotation.title = username
                            self.map.addAnnotation(objectAnnotation)
                            }
                            }
                        }
                    }
                }
            }
        }
        addLongPressGesture()
        }

    func saveLocation(center:CLLocationCoordinate2D)
    {
        let x:Double = center.latitude
        let y:Double = center.longitude
        let username = prefs.objectForKey("USERNAME") as! String
        do {
            let post:NSString = "username=\(username)&x=\(x)&y=\(y)"
            
            NSLog("PostData: %@",post);
            
            let url:NSURL = NSURL(string:"http://angelicapp.com/POCA/jsonSetLocationOnMap.php")!
            
            let postData:NSData = post.dataUsingEncoding(NSASCIIStringEncoding)!
            
            let postLength:NSString = String( postData.length )
            
            let request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
            request.HTTPMethod = "POST"
            request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
            request.HTTPBody = postData
            request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            
            var response: NSURLResponse?
            
            var urlData: NSData?
            do
            {
                urlData = try NSURLConnection.sendSynchronousRequest(request, returningResponse:&response)
            }
            catch  _ as NSError
            {
                urlData = nil
            }
            
            if ( urlData != nil )
            {
                let res = response as! NSHTTPURLResponse!;
                
                //NSLog("Response code: %ld", res.statusCode);
                
                if (res.statusCode >= 200 && res.statusCode < 300)
                {
                    let responseData:NSString  = NSString(data:urlData!, encoding:NSUTF8StringEncoding)!
                    
                    NSLog("Response ==> %@", responseData);
                }
            }
        }
        addLongPressGesture()
    }
    
    @IBAction func exitMap(sender: UIButton)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
