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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    @IBAction func manualButtonTapped(sender: AnyObject) {
        SettingsController.sharedController.playSound()
        LocationController.sharedInsance.getCurrentLocation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        
//        let dummy = ["dummy":45.55]
//        NetworkController.googleMapsDirections(dummy, destination: dummy) { (time, trafficTime, error) -> Void in
//            guard let time = time, let trafficTime = trafficTime else {return}
//            print(time)
//            print(trafficTime)
//            print("")
//        }
        
        
        tableViewOutlet.layer.borderWidth = 2.5
        tableViewOutlet.layer.borderColor = UIColor.whiteColor().CGColor
        tableViewOutlet.layer.cornerRadius = 5
        
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: "intervalUpdate", name: "updateInterval", object: nil)
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleNotification:", name: "locationUpdated", object: nil)

        UIApplication.sharedApplication().registerUserNotificationSettings(UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil))
        
        
        LocationController.sharedInsance.getCurrentLocation()
        //notificationTest()
        
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
            let dVC = segue.destinationViewController as! ChooseAddressViewController
            dVC.firstUser = true
        }
    }
}
