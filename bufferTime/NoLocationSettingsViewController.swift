//
//  NoLocationSettingsViewController.swift
//  bufferTime
//
//  Created by Michael Wilkowski on 1/20/16.
//  Copyright © 2016 JustWilks. All rights reserved.
//

import UIKit
import MapKit



class NoLocationSettingsViewController: UIViewController {

    @IBOutlet weak var settingsButtonOutlet: UIButton!
    
    @IBOutlet weak var doneButtonOutlet: UIButton!
    @IBOutlet weak var textViewOutlet: UITextView!
    
    @IBAction func settingsButtonTapped(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: UIApplicationOpenSettingsURLString)!)
    }
        
    enum ViewMode {
        case Notifications
        case Location
    }
    
    func checkBothSettings(){
        if let notificationSettings = UIApplication.sharedApplication().currentUserNotificationSettings() {
            if (notificationSettings.types.contains(.Alert)) || (notificationSettings.types.contains(.Sound)) && CLLocationManager.authorizationStatus() == .AuthorizedAlways {
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
    }
    @IBAction func doneButtonTapped(sender: AnyObject) {
        checkBothSettings()
    }
    
    var viewMode = ViewMode.Notifications
    
    func setupButtons(){
        settingsButtonOutlet.layer.borderColor = UIColor.whiteColor().CGColor
        settingsButtonOutlet.layer.borderWidth = 2
        settingsButtonOutlet.layer.cornerRadius = 5
        
        doneButtonOutlet.layer.borderColor = UIColor.whiteColor().CGColor
        doneButtonOutlet.layer.borderWidth = 2
        doneButtonOutlet.layer.cornerRadius = 5
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if viewMode == .Location {
        textViewOutlet.text = "In order for the app to incorporate live traffic data properly we need the 'Location Settings' to be set to 'Always', it will only use your location on days where there is candle lighting from 12:00pm untill candle lighting time."
        settingsButtonOutlet.setTitle("Turn Location On", forState: .Normal)
        } else {
            textViewOutlet.text = "In order for the app to notify you to leave at the correct time it needs Notification Settins to be on. It will only notify you when it is time to leave to get home with enough time to prepare with the time you specified."
            settingsButtonOutlet.setTitle("Turn Notifications On", forState: .Normal)
        }
    }
}
