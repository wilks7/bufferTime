//
//  ViewController.swift
//  bufferTime
//
//  Created by Michael Wilkowski on 12/21/15.
//  Copyright © 2015 JustWilks. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UserController.sharedController.currentUser = User(time: NSTimeInterval(1))
        
        UIApplication.sharedApplication().registerUserNotificationSettings(UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil))

        
        let candleDates = String()
        
        if getDayOfWeek() == 6 {
            LocationController.sharedInsance.getCurrentLocation()
            print("getting location")
        }
        
        if !candleDates.containsString(dateFormat()){
            LocationController.sharedInsance.getCurrentLocation()
            print("getting location")

        }

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleNotification:", name: "locationUpdated", object: nil)
        
        NetworkController.fetchBasedOnLocation("11581") { (holidays, candles, error) -> Void in
            if let candles = candles {
                print(candles.count)
            }
        }
        
        
    }
    
    func handleNotification(notification: NSNotification) {
        if let location = notification.userInfo!["location"] as? CLLocation {
            print("Current Location: \(location)")
            
        }
        if let stringName = notification.userInfo!["stringLocation"] as? String {
            print(stringName)
        }
        
        if let zip = notification.userInfo!["zip"] as? String {
            print(zip)
        }
    }
    
    func setNotification(fireDate: NSDate) {
        let alarmNotification = UILocalNotification()
        alarmNotification.fireDate = fireDate
        alarmNotification.timeZone = NSTimeZone.localTimeZone()
        alarmNotification.soundName = "sms-received3.caf"
        alarmNotification.alertBody = "Alarm Complete!"
        
        UIApplication.sharedApplication().scheduleLocalNotification(alarmNotification)
    }

    func dateFormat()->String{
        let formatter = NSDateFormatter()
        formatter.dateStyle = .ShortStyle
        let dateString = formatter.stringFromDate(NSDate())
        return dateString
    }
    
    func getDayOfWeek()->Int {
        let todayDate = NSDate()
        let myCalendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)
        let myComponents = myCalendar?.components(.Weekday, fromDate: todayDate)
        let weekDay = myComponents?.weekday
        return weekDay!
    }
}