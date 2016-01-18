//
//  FirstViewController.swift
//  bufferTime
//
//  Created by Michael Wilkowski on 1/11/16.
//  Copyright © 2016 JustWilks. All rights reserved.
//

import UIKit
import CoreLocation

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableViewOutlet: UITableView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewOutlet.layer.borderWidth = 5
        tableViewOutlet.layer.borderColor = UIColor.whiteColor().CGColor
        tableViewOutlet.layer.cornerRadius = 5
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "intervalUpdate", name: "updateInterval", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleNotification:", name: "locationUpdated", object: nil)

        UIApplication.sharedApplication().registerUserNotificationSettings(UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil))
        
        
        LocationController.sharedInsance.getCurrentLocation()
        notificationTest()
        
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if !(SettingsController.sharedController.checkNS()){
            self.performSegueWithIdentifier("firstUser", sender: nil)
            print("no device settings")
        }else{
            print("device has settings")
        }
    }
    
    
    func handleNotification(notification: NSNotification) {
        if let location = notification.userInfo!["location"] as? CLLocation {
            print("Current Location: \(location)")
            
        }
        if let stringName = notification.userInfo!["stringLocation"] as? String {
            print("Current Address: \(stringName)")
        }
        
        if let zip = notification.userInfo!["zip"] as? String {
            print("Zip: \(zip)")
        }
    }
    
    func intervalUpdate(){
        print("ninja we made it")
    }
    
    func shabbosReminder(){
        
    }
    
    func set30minIntervals(candleTime: NSDate){
        
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
    
    // MARK: TableView DataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellID", forIndexPath: indexPath)
        
        cell.textLabel?.text = "test"
        
        return cell
    }
    
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "firstUser"{
            let dVC = segue.destinationViewController as! ChooseAddressViewController
            dVC.firstUser = true
        }
    }
}
