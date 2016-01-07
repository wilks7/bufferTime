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

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let userDic = NSUserDefaults.standardUserDefaults().valueForKey("user") as? [String:AnyObject]
            else {return}
    
        if let address = userDic["address"] as? CLLocation{
            LocationController.sharedInsance.addressForLocation(address, completion: { (stringLocation, zip) -> Void in
                self.label.text = stringLocation
            })
//            let myString = address.description
//            label.text = myString
        }
        
        if let coordinates = userDic["address"] as? [String:AnyObject] {
            
            guard let longitude = coordinates["lon"] as? Double,
                let latitude = coordinates["lat"] as? Double else {return}
            
            let location = CLLocation(latitude: latitude, longitude: longitude)
            
            LocationController.sharedInsance.addressForLocation(location, completion: { (stringLocation, zip) -> Void in
                self.label.text = stringLocation
            })
            
            
        }
    }

    

}
