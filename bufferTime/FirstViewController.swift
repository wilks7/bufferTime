//
//  FirstViewController.swift
//  bufferTime
//
//  Created by Michael Wilkowski on 1/11/16.
//  Copyright © 2016 JustWilks. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    
    
    
    @IBAction func chooseBufferTapped(sender: AnyObject) {
        self.performSegueWithIdentifier("noNSuser", sender: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let notificationSettings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)
        
        let date = NSDate()
        //let newDate = date.dateByAddingTimeInterval(15)
        
        let format = NSDateFormatter()
        format.dateFormat = "MM/dd/yy-hh:mm:ss"
        
        let string = format.stringFromDate(date)
        let myDate = format.dateFromString(string)
        guard let dater = myDate else {return}
        
        let silentAlert = UILocalNotification()
        silentAlert.fireDate = date.dateByAddingTimeInterval(10)
        silentAlert.userInfo = ["silent" : true]
        silentAlert.alertBody = "Testing"
        silentAlert.alertAction = "teeesstt"
        silentAlert.soundName = UILocalNotificationDefaultSoundName
        silentAlert.timeZone = NSTimeZone.localTimeZone()
        UIApplication.sharedApplication().scheduleLocalNotification(silentAlert)

    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if !(SettingsController.sharedController.checkNS()){
            self.performSegueWithIdentifier("noNSuser", sender: nil)
            print("out")
        }else{
            print("in")
        }
    }
}
