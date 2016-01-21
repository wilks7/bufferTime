//
//  CheckSettingsViewController.swift
//  bufferTime
//
//  Created by Michael Wilkowski on 1/20/16.
//  Copyright © 2016 JustWilks. All rights reserved.
//

import UIKit
import MapKit

class CheckSettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.performSegueWithIdentifier("next", sender: nil)
//        if SettingsController.sharedController.checkNS(){
//            self.performSegueWithIdentifier("next", sender: nil)
//        }else{
//            UIApplication.sharedApplication().registerUserNotificationSettings(UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil))
//            LocationController.sharedController.locationManager.requestAlwaysAuthorization()
//            
//            let alert = UIAlertController(title: "Settings", message: "We will only send you a notification when it is time to leaev and will only use your location for checking traffic times", preferredStyle: .Alert)
//            let okButton = UIAlertAction(title: "OK", style: .Default) { (_) -> Void in
//                self.performSegueWithIdentifier("next", sender: nil)
//            }
//            alert.addAction(okButton)
//            presentViewController(alert, animated: true, completion: nil)
//        }
        
    }
}
