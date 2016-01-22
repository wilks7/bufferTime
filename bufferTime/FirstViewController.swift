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

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableViewOutlet: UITableView!
    
    static let sharedInstance = FirstViewController()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    @IBAction func manualButtonTapped(sender: AnyObject) {
        SettingsController.sharedController.playSound()
        
        LocationController.sharedController.locationManager.delegate = LocationController.sharedController
        LocationController.sharedController.locationManager.distanceFilter = 10
        LocationController.sharedController.locationManager.startUpdatingLocation()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewOutlet.layer.borderWidth = 2.5
        tableViewOutlet.layer.borderColor = UIColor.whiteColor().CGColor
        tableViewOutlet.layer.cornerRadius = 5
        testStuff()
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
    
    // MARK: TableView DataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let parshaCell = tableView.dequeueReusableCellWithIdentifier("parsha", forIndexPath: indexPath)
        let candleCell = tableView.dequeueReusableCellWithIdentifier("candle", forIndexPath: indexPath)
        let extraCell = tableView.dequeueReusableCellWithIdentifier("extra", forIndexPath: indexPath)
        
        parshaCell.textLabel?.text = "Parsha"
        candleCell.textLabel?.text = "Candle"
        extraCell.textLabel?.text = "Extra"
        
        parshaCell.textLabel?.textColor = .whiteColor()
        candleCell.textLabel?.textColor = .whiteColor()
        extraCell.textLabel?.textColor = .whiteColor()
        
        switch indexPath.row {
        case 0:
            return parshaCell
        case 1:
            return candleCell
        case 2:
            return extraCell
        default:
            return parshaCell
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
    
    
    func testStuff(){
        JsonController.queryHolidays()
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
