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
        
        guard let userNSDic = NSUserDefaults.standardUserDefaults().valueForKey("user") as? [String:AnyObject]
            else {return}
    
        
        if let coordinates = userNSDic["address"] as? [String:AnyObject] {
            
            guard let longitude = coordinates["lon"] as? Double,
                let latitude = coordinates["lat"] as? Double else {return}
            
            let location = CLLocation(latitude: latitude, longitude: longitude)
            
            LocationController.sharedInsance.addressFromLocation(location, completion: { (stringLocation, zip) -> Void in
                self.label.text = zip
                NetworkController.fetchBasedOnZip(zip) { (holidays, candles, error) -> Void in
                    if let candles = candles {
                        print("Candles: \(candles.count)")
                    }
                }
            })            
        }
    }

    

}
