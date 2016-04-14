//
//  FirstViewController.swift
//  bufferTime
//
//  Created by Michael Wilkowski on 1/11/16.
//  Copyright © 2016 JustWilks. All rights reserved.
//

import UIKit
import Parse
import CoreLocation

class FirstViewController: UIViewController {

    @IBOutlet weak var tableViewOutlet: UITableView!
    
    @IBOutlet weak var parshaLabel: UILabel!
    @IBOutlet weak var parshaHebrewLabel: UILabel!
    
    @IBOutlet weak var candleLabel: UILabel!
    
    @IBOutlet weak var extraLabel: UILabel!
    
    @IBOutlet weak var stackViewOutlet: UIStackView!
    
    @IBOutlet weak var manualButtonOutlet: UIButton!
    
    
    static let sharedInstance = FirstViewController()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    @IBAction func manualButtonTapped(sender: AnyObject) {
        SettingsController.sharedController.playSound()
        
        LocationController.sharedController.locationManager.delegate = LocationController.sharedController
        LocationController.sharedController.locationManager.distanceFilter = 10
        LocationController.sharedController.locationManager.startUpdatingLocation()
        LocationController.sharedController.locationManager.requestLocation()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "fetch:", name: "getZip", object: nil)
        if let zip = NSUserDefaults.standardUserDefaults().valueForKey("homeZip") as? String {
            NetworkController.getShabbosTime(zip) { (error, candleTime, havdalahTime) in
                if let candleString = candleTime, let havdalahString = havdalahTime {
                    let candle = candleString.substringFromIndex(candleString.endIndex.advancedBy(-6))
                    let havdalah = havdalahString.substringFromIndex(havdalahString.endIndex.advancedBy(-6))
                    self.candleLabel.text = candle
                    self.extraLabel.text = havdalah
                }
            }

        }
        
        manualButtonOutlet.hidden = true

        
        LocationController.sharedController.locationManager.delegate = LocationController.sharedController
        LocationController.sharedController.locationManager.requestLocation()
        
        stackViewOutlet.layer.borderWidth = 1.5
        stackViewOutlet.layer.borderColor = UIColor.whiteColor().CGColor
        stackViewOutlet.layer.cornerRadius = 5
        
        if let holiday = JsonController.queryHolidays(){
            extraLabel.text = holiday.name
        }
        
        if let parsha = JsonController.queryParshas() {
            parshaLabel.text = parsha.title
            parshaHebrewLabel.text = parsha.hebrew
        }
        
        
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        alertCheckSettings()
        if !(SettingsController.sharedController.checkNS()){
            self.performSegueWithIdentifier("firstUser", sender: nil)
            print("no device settings")
        }else{
            print("device has settings")
        }
    }
    
    func fetch(notification: NSNotification){
        if let zip = notification.userInfo!["zip"] as? String {
            
//            NetworkController.getShabbosTime(zip) { (error, candleTime, havdalahTime) in
//                if let candleString = candleTime, let havdalahString = havdalahTime {
//                    let candle = candleString.substringFromIndex(candleString.endIndex.advancedBy(-6))
//                    let havdalah = havdalahString.substringFromIndex(havdalahString.endIndex.advancedBy(-6))
//                    self.candleLabel.text = candle
//                    self.extraLabel.text = havdalah
//                }
//            }
            NetworkController.fetchBasedOnZip(zip, completion: { (holidays, candles, parshas, error) -> Void in
                if let candles = candles {
                    let formatter = NSDateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd"
                    let todayString = formatter.stringFromDate(NSDate())
                    
                    for candle in candles {
                        let candleString = formatter.stringFromDate(candle.date)
                        if todayString < candleString {
                            //completion(candleTime: candle.stringDate())
                            //self.extraLabel.text = candleString
                            self.reloadInputViews()
                        }
                    }
                }
            })
        }
    }
    
    func alertCheckSettings(){
        UIApplication.sharedApplication().registerUserNotificationSettings(UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil))
        LocationController.sharedController.locationManager.requestAlwaysAuthorization()
        
        if !checkSettings(){
        
            let alert = UIAlertController(title: "Settings", message: "We will only send you a notification when it is time to leaev and will only use your location for checking traffic times", preferredStyle: .Alert)
            let okButton = UIAlertAction(title: "OK", style: .Default) { (_) -> Void in
                if let notificationSettings = UIApplication.sharedApplication().currentUserNotificationSettings() {
                    if !(notificationSettings.types.contains(.Alert)) || !(notificationSettings.types.contains(.Sound)){
                        self.performSegueWithIdentifier("turnOnSettings", sender: true)
                    }
                    if (CLLocationManager.authorizationStatus() == .Denied || CLLocationManager.authorizationStatus() == .Restricted || CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse) {
                        self.performSegueWithIdentifier("turnOnSettings", sender: false)
                    }
                }
            }
            alert.addAction(okButton)
            presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    func checkSettings()->Bool{
        guard let notificationSettings = UIApplication.sharedApplication().currentUserNotificationSettings() else {return false}
        
                
        if (CLLocationManager.authorizationStatus() == .AuthorizedAlways) && ((notificationSettings.types.contains(.Alert)) && (notificationSettings.types.contains(.Sound))) {
            return true
        } else {
            return false
        }
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "firstUser"{
            let nav = segue.destinationViewController as! UINavigationController
            let dVC = nav.viewControllers.first as! ChooseAddressViewController
            dVC.firstUser = true
        } else if segue.identifier == "turnOnSettings"{
            let dVC = segue.destinationViewController as! NoLocationSettingsViewController
            guard let sender = sender as? Bool else {return}
            
            if sender{
                dVC.viewMode = .Notifications
            }
            else{
                dVC.viewMode = .Location
            }
        }
    }
    
    
    func notificationTest(){
        let date = NSDate()
        
        let format = NSDateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        
        let string = format.stringFromDate(date)
        let myDate = format.dateFromString(string)
        guard let dater = myDate else {return}
        
        let silentAlert = UILocalNotification()
        silentAlert.fireDate = dater.dateByAddingTimeInterval(10)
        silentAlert.userInfo = ["silent" : true]
        silentAlert.alertBody = "Testing"
        silentAlert.alertAction = "teeesstt"
        silentAlert.soundName = UILocalNotificationDefaultSoundName
        silentAlert.timeZone = NSTimeZone.localTimeZone()
        UIApplication.sharedApplication().scheduleLocalNotification(silentAlert)
        NSNotificationCenter.defaultCenter().postNotificationName("updateInterval", object: nil, userInfo: ["NStest":"thisIsTest"])
    }
}
