//
//  LabelViewController.swift
//  bufferTime
//
//  Created by Michael Wilkowski on 12/23/15.
//  Copyright © 2015 JustWilks. All rights reserved.
//

import UIKit
import MapKit

class LabelViewController: UIViewController {
    
    var zip = ""
    
    var address = ""
    
    @IBOutlet weak var map: MKMapView!
    
    @IBOutlet weak var addressLabel: UILabel!

    @IBOutlet weak var timeLabel: UILabel!
    @IBAction func resetButtonTapped(sender: AnyObject) {
    }
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        NetworkController.fetchBasedOnZip(zip) { (holidays, candles, error) -> Void in
            if let candles = candles {
                print("Candles: \(candles.count)")
            }
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
        if let coordinates = NSUserDefaults.standardUserDefaults().valueForKey("addressCoordinates") as? [String : Double]{
            
            guard let longitude = coordinates["longitude"],
                let latitude = coordinates["latitude"] else {return}
            
            let location = CLLocation(latitude: latitude, longitude: longitude)
            
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            
            
            let anotation = Home(title: "Home", coordinate: CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude), info: "Spend Shabbos")
            
            self.map.setRegion(region, animated: true)
            self.map.addAnnotation(anotation)
            
            
            LocationController.sharedInsance.addressFromLocation(location, completion: { (stringLocation, zip) -> Void in
                self.addressLabel.text = stringLocation
            })
            
        }
        
        if let buffer = NSUserDefaults.standardUserDefaults().valueForKey("bufferTime"){
            
            if let buffer = buffer as? Int{
                let totalMinutes = buffer/60
                let hours = totalMinutes/60
                let minutes = totalMinutes%60
                self.timeLabel.text = String(hours)+" hours and "+String(minutes)+" minutes"
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.map.layer.borderWidth = 5
        self.map.layer.borderColor = UIColor.whiteColor().CGColor
    }

}
